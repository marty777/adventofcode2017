import Foundation;

class Day05: PuzzleDay {
	
	static func part1(input:[Int]) -> Int{
		var index = 0
		var steps = 0
		var jumps = input
		while index >= 0 && index < jumps.count {
			let i = index
			index += jumps[i]
			jumps[i] += 1
			steps += 1
		}
		return steps
	}
	
	static func part2(input:[Int]) -> Int{
		var index = 0
		var steps = 0
		var jumps = input
		while index >= 0 && index < jumps.count {
			let i = index
			index += jumps[i]
			if jumps[i] >= 3 {
				jumps[i] -= 1
			}
			else {
				jumps[i] += 1
			}
			steps += 1
		}
		return steps
	}
	
	static func run(inputPath:String) {
		print("Running Day 2 with input file \(inputPath)")
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var jumps:[Int] = []
		for line in lines {
			if line.count == 0 {
				continue
			}
			jumps.append(Int(line)!)
		}
		
		let part1 = self.part1(input:jumps)
		let part2 = self.part2(input:jumps)
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}