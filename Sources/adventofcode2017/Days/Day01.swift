import Foundation;

class Day01: PuzzleDay {
	static func run(inputPath:String) {
		print("Running Day 1 with input file \(inputPath)")
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		let line = lines[0]
		var part1 = 0
		var part2 = 0
		for i in 0...line.count-1 {
			let part1_index = (i+1) % line.count
			let part2_index = (i + line.count/2) % line.count
			if line[i] == line[part1_index] {
				part1 += Int(line[i])!
			}
			if line[i] == line[part2_index] {
				part2 += Int(line[i])!
			}
		}
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}