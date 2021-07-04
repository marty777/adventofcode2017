import Foundation;

class Day12: PuzzleDay {
	
	struct Pipe {
		var index:Int
		var neighbors:[Int]
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var pipes:[Pipe] = []
		for line in lines {
			if line.count == 0 {
				continue
			}
			let parts = line.components(separatedBy:" <-> ")
			let index = Int(parts[0])!
			let neighbors = parts[1].components(separatedBy:", ")
			var neighborArr:[Int] = []
			for n in neighbors {
				neighborArr.append(Int(n)!)
			}
			pipes.append(Pipe(index:index, neighbors:neighborArr))
		}
		
		var assignments:[Int] = [Int](repeating:-1, count:pipes.count)
		var assignedCount = 0
		var part1 = 0
		var part2 = 0
		while assignedCount < pipes.count {
			for i in 0..<pipes.count {
				if assignments[i] != -1 {
					continue
				}
				var stack:[Int] = []
				assignments[i] = part2
				for j in pipes[i].neighbors {
					stack.append(j)
				}
				while stack.count > 0 {
					let j = stack.removeLast()
					assignments[j] = part2
					for k in pipes[j].neighbors {
						if assignments[k] == -1 {
							stack.append(k)
						}
					}
				}
				part2 += 1
			}
			assignedCount = 0
			for i in 0..<pipes.count {
				if assignments[i] != -1 {
					assignedCount += 1
				}
			}
		}
		for a in assignments {
			if a == 0 {
				part1 += 1
			}
		}
		
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}