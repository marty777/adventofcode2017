import Foundation;

class Day02: PuzzleDay {
	static func run(inputPath:String) {
		print("Running Day 2 with input file \(inputPath)")
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var part1 = 0
		var part2 = 0
		// space and tab separators
		let separators = CharacterSet(charactersIn: " \t")
		for line in lines {
			var lineMin = -1
			var lineMax = -1
			var lineDividend = -1;
			var lineDivisor = -1;
			let split = line.components(separatedBy: separators)
			for i in 0...split.count-1 {
				let val = Int(split[i]) ?? -1
				if val == -1 {
					continue
				}
				if lineMin == -1 || val < lineMin {
					lineMin = val
				}
				if lineMax == -1 || val > lineMax {
					lineMax = val
				}
				if lineDivisor == -1 {
					for j in 0...split.count - 1 {
						if j == i {
							continue
						}
						let val2 = Int(split[j]) ?? -1
						if val2 == -1 {
							continue
						}
						if val % val2 == 0 {
							lineDividend = val
							lineDivisor = val2
							break
						}
					}
				}
			}
			if lineMin == -1 {
				continue;
			}
			part1 += lineMax - lineMin
			part2 += lineDividend/lineDivisor;
		}
		
		
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}