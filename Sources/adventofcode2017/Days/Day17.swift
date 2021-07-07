import Foundation;

class Day17: PuzzleDay {

	struct ListNode {
		let value:Int
		var prev:Int
		var next:Int
	}
	
	static func insert(nodes: inout [Int:ListNode], index: inout Int, steps:Int, value:Int) {
		var s = 0
		while s < steps {
			index = nodes[index]!.next
			s += 1
		}
		let prev = index
		let next = nodes[index]!.next
		nodes[value] = ListNode(value:value, prev:prev, next:next)
		nodes[prev]!.next = value
		nodes[next]!.prev = value
		index = value
	}
	
	static func printNodes(nodes:[Int:ListNode], index:Int) {
		var pos = 0
		while true {
			if pos == index {
				print("(\(nodes[pos]!.value)) ", terminator:"")
			}
			else {
				print("\(nodes[pos]!.value) ", terminator:"")
			}
			pos = nodes[pos]!.next
			if pos == 0 {
				break
			}
		}
		print("")
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		let steps = Int(lines[0])!
		
		var nodes:[Int:ListNode] = [:]
		nodes[0] = ListNode(value:0, prev:1, next:1)
		nodes[1] = ListNode(value:1, prev:0, next:0)
		var index = 1
		for i in 2...2017 {
			insert(nodes:&nodes, index:&index, steps:steps, value:i)
		}
		let part1 = nodes[2017]!.next
		
		var pos = 1
		var part2 = 0
		for i in 1...50_000_000 {
			pos = (pos + steps + 1) % (i)
			if pos == 0 {
				part2 = i
			}
		}
		
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}