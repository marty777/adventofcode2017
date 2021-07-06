import Foundation;

class Day15: PuzzleDay {
	
	
	static func next(prev:Int, factor:Int) -> Int {
		return ((prev * factor) % 2147483647)
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		let genAStart = Int(lines[0].substring(fromIndex:"Generator A starts with ".count))!
		let genBStart = Int(lines[1].substring(fromIndex:"Generator B starts with ".count))!
		
		let genAFactor = 16807
		let genBFactor = 48271
		
		var genA = genAStart
		var genB = genBStart
		var part1 = 0
		
		for _ in 0..<40_000_000 {
			genA = next(prev:genA, factor:genAFactor)
			genB = next(prev:genB, factor:genBFactor)
			if (genA & 0xffff) == (genB & 0xffff) {
				part1 += 1
			}
		}
		print("Part 1:", part1)
		
		var part2 = 0
		genA = genAStart
		genB = genBStart
		var availableA = false
		var availableB = false
		var pairCount = 0
		while pairCount < 5_000_000 {
			if !availableA {
				genA = next(prev:genA, factor:genAFactor)
				if genA % 4 == 0 {
					availableA = true
				}
			}
			if !availableB {
				genB = next(prev:genB, factor:genBFactor)
				if genB % 8 == 0 {
					availableB = true
				}
			}
			
			if availableA && availableB {
				if (genA & 0xffff) == (genB & 0xffff) {
					part2 += 1
				}
				pairCount += 1
				availableA = false
				availableB = false
			}
		}
		print("Part 2:", part2)
	}
}