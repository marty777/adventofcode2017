import Foundation;

class Day09: PuzzleDay {
	
	static func traverse(input:String) -> (Int,Int) {
		// much faster to do character access through
		// a character array than using string slices
		let line = Array(input)
		var index = 1
		var level = 1
		let end = line.count - 1
		var on_garbage = false
		var garbage_count = 0
		var sum = 1
		while index < end {
			if !on_garbage && line[index] == "{" {
				level += 1
			}
			else if !on_garbage && line[index] == "}" {
				sum += level
				level -= 1
			}
			else if !on_garbage && line[index] == "<" {
				on_garbage = true
			}
			else if on_garbage && line[index] == ">" {
				on_garbage = false
			}
			else if on_garbage && line[index] == "!" {
				index += 1
			}
			else if on_garbage {
				garbage_count += 1
			}
			index += 1
		}
		return (sum, garbage_count)
	}
	
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		let line = lines[0]
		let (part1, part2) = traverse(input:line)
		
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}