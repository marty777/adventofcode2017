import Foundation;

class Day04: PuzzleDay {
	
	static func run(inputPath:String) {
		print("Running Day 2 with input file \(inputPath)")
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var part1 = 0;
		var part2 = 0;		
		for line in lines {
			if line.count == 0 {
				continue
			}
			let split = line.components(separatedBy:" ")
			var found = false
			var found_anagram = false
			for i in 0...split.count - 1 {
				let sorted_i = split[i].sorted()
				for j in 0...split.count - 1 {
					if i == j {
						continue
					}
					if split[i] == split[j] {
						found = true
					}
					let sorted_j = split[j].sorted()
					if sorted_j == sorted_i {
						found_anagram = true
					}
					if found && found_anagram {
						break
					}
				}
				if found && found_anagram {
					break
				}
				
			}
			if !found {
				part1 += 1
			}
			if !found_anagram {
				part2 += 1
			}
		}
		
		
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}