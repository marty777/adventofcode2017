import Foundation;

class Day11: PuzzleDay {
	
	static func posToSteps(x:Int, y:Int) -> Int {
		var steps = 0
		var x1 = x
		var y1 = y
		while !(x1 == 0 && y1 == 0) {
			// se
			if x1 >= 1 && y1 <= -1 {
				x1 -= 1
				y1 += 1
			}
			// ne
			else if x1 >= 1 {
				x1 -= 1
			}
			// nw
			else if x1 <= -1 && y1 >= 1 {
				x1 += 1
				y1 -= 1
			}
			// sw
			else if x1 <= -1 {
				x1 += 1
			}
			// n
			else if y1 >= 1 {
				y1 -= 1
			}
			// s
			else if y1 <= -1 {
				y1 += 1
			}
			else {
				return 0
			}
			steps += 1
		}
		return steps
	}
	
	static func follow(directions:[String]) -> (Int,Int) {
		var x = 0
		var y = 0
		var steps = 0
		var maxSteps = 0
		// minor speedup using cached positions for part 2
		var seen:[String:Int] = [:]
		for dir in directions {
			switch(dir) {
				case "n":
					y += 1
				case "s":
					y -= 1
				case "nw":
					y += 1
					x -= 1
				case "ne":
					x += 1
				case "sw":
					x -= 1
				case "se":
					y -= 1
					x += 1
				default:
					print("Unknown direction found \(dir)")
					return (0,0)
			}
			let key:String = "\(x),\(y)"
			if seen[key] == nil {
				steps = posToSteps(x:x, y:y)
				seen[key] = steps
				if steps > maxSteps {
					maxSteps = steps
				}
			}

		}
		return (steps, maxSteps)
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		let directions = lines[0].components(separatedBy:",")
		
		
		let (part1, part2) = follow(directions:directions)
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}