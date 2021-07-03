import Foundation;

class Day10: PuzzleDay {
	
	static func reverse(nodes: inout [Int], startIndex:Int, length:Int) {
		var stack:[Int] = []
		for i in 0..<length {
			let index = (startIndex + i) % nodes.count
			stack.append(nodes[index])
		}
		for i in 0..<length {
			let index = (startIndex + i) % nodes.count
			nodes[index] = stack[stack.count - 1 - i]
		}
	}
	
	static func round(nodes: inout [Int], lengths:[Int], index: inout Int, skipSize: inout Int) {
		for length in lengths {
			reverse(nodes: &nodes, startIndex:index, length:length)
			index = (index + length + skipSize) % nodes.count
			skipSize += 1
		}
	}
	
	static func reduceToHex(nodes:[Int]) -> String {
		assert(nodes.count == 256, "incorrect number of nodes: \(nodes.count)")
		var ret = ""
		var accumulator:Int
		for i in 0..<16 {
			accumulator = 0
			for j in 0..<16 {
				accumulator ^= nodes[16*i + j]
			}
			ret += String(format:"%02X", accumulator)
		}
		return ret
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var lengths:[Int] = []
		var lengths2:[Int] = []
		let components = lines[0].components(separatedBy:",")
		for c in components {
			lengths.append(Int(c)!)
		}
		
		let lineArr = Array(lines[0])
		for c in lineArr {
			let ascii = Int(c.asciiValue!)
			lengths2.append(ascii)
		}
		lengths2.append(17)
		lengths2.append(31)
		lengths2.append(73)
		lengths2.append(47)
		lengths2.append(23)
		
		let numNodes = 256
		var nodes:[Int] = []
		var nodes2:[Int] = []
		for i in 0..<numNodes {
			nodes.append(i)
			nodes2.append(i)
		}
		
		var skipSize = 0
		var index = 0
		round(nodes:&nodes, lengths:lengths, index:&index, skipSize:&skipSize)
		let part1 = nodes[0] * nodes[1]
		
		index = 0
		skipSize = 0
		for _ in 0..<64 {
			round(nodes:&nodes2, lengths:lengths2, index:&index, skipSize:&skipSize)
		}
		let part2 = reduceToHex(nodes:nodes2)
		
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}