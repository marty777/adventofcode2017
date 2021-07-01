import Foundation;

class Day07: PuzzleDay {
	
	struct Node {
		let name: String
		let weight: Int
		let index: Int
		var childNames: [String]
	}
	
	static func weightRecurse(nodes:[Node], indices:[String:Int], name:String) -> Int {
		if nodes[indices[name]!].childNames.count == 0 {
			return nodes[indices[name]!].weight
		}
		var weight = nodes[indices[name]!].weight
		for child in nodes[indices[name]!].childNames {
			weight += weightRecurse(nodes:nodes, indices:indices, name:child)
		}
		return weight
	}	
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var nodes:[Node] = []
		var index = 0
		for line in lines {
			if line.count == 0 {
				continue
			}
			let scanner = Scanner(string:line)
			var name:String?
			var weight:Int = 0
			name = scanner.scanUpToString(" (")
			scanner.scanUpToCharacters(from:CharacterSet.decimalDigits)
			scanner.scanInt(&weight)
			var node = Node(name:name!, weight:weight, index:index, childNames:[])
			if line.index(of:"->") != nil {
				let split = line.components(separatedBy:" -> ")
				let children = split[1].components(separatedBy:", ")
				for child in children {
					node.childNames.append(child)
				}
			}
			nodes.append(node)
			index += 1
		}
		var nodeIndices:[String:Int] = [:]
		for node in nodes {
			nodeIndices[node.name] = node.index
		}
		var part1 = 0
		while true {
			var parentFound = false
			for i in 0..<nodes.count {
				if i == part1 {
					continue
				}
				if nodes[i].childNames.contains(nodes[part1].name) {
					parentFound = true
					part1 = i
					break
				}
			}
			if !parentFound {
				break
			}
		}
		print("Part 1:", nodes[part1].name)
		
		// find node balanced above that differs from neighbors
		index = part1
		var part2 = 0
		var neighborWeight = 0
		while true {
			var balanced = false
			var weightNode:[Int:String] = [:]
			var weightCount:[Int:Int] = [:]
			for c in nodes[index].childNames {
				let weight = weightRecurse(nodes:nodes, indices:nodeIndices, name:c)
				weightNode[weight] = c
				if weightCount[weight] == nil {
					weightCount[weight] = 1
				}
				else {
					weightCount[weight]! += 1
				}
			}
			if weightCount.keys.count == 1 {
				part2 = nodes[index].weight - (weightRecurse(nodes:nodes, indices:nodeIndices, name:nodes[index].name) - neighborWeight)
				break
			}
			// move to the next unbalanced child
			for k in weightCount.keys {
				if weightCount[k] != 1 {
					neighborWeight = k
				}
				else {
					index = nodeIndices[weightNode[k]!]!
				}
			}
			
		}
		
		print("Part 2:", part2)
	}
}