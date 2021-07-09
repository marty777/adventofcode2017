import Foundation;

class Day21: PuzzleDay {
	
	static func enhance(grid:[Bool], gridDim:Int, rules:[Int:Int]) -> ([Bool], Int){
		var sectionDim = 3
		if gridDim % 2 == 0 {
			sectionDim = 2
		}
		let sections = (gridDim*gridDim)/(sectionDim * sectionDim)
		let nextGridDim = (gridDim*(sectionDim + 1))/sectionDim
		var nextGrid = [Bool](repeating:false, count:nextGridDim*nextGridDim)
		var startX = 0
		var startY = 0
		var startX2 = 0
		var startY2 = 0
		for s in 0..<sections {
			if s > 0 {
				startX += sectionDim
				startX2 += (sectionDim+1)
				if startX >= gridDim {
					startX = 0
					startX2 = 0
					startY += sectionDim
					startY2 += (sectionDim+1)
				}
			}
			
			var sectionInt = 0
			var sectionIntPos = 0
			for y in 0..<sectionDim {
				for x in 0..<sectionDim {
					sectionInt |= ((grid[((startY + y) * gridDim) + (startX + x)] ? 1 : 0) << sectionIntPos)
					sectionIntPos += 1
				}
			}
			// prevent dictionary collisions between 3x3 and 2x2 rules
			if sectionDim == 3 {
				sectionInt |= 65536
			}
			assert(rules[sectionInt] != nil, "enhance: Unmatched rule for section \(s) with key \(sectionInt)")
			let rule = rules[sectionInt]!
			var rulePos = 0
			for y in 0..<(sectionDim+1) {
				for x in 0..<(sectionDim+1) {
					nextGrid[((startY2 + y) * nextGridDim) + (startX2 + x)] = (((rule >> rulePos) & 0x1) == 1)
					rulePos += 1
				}
			}
		}
		return (nextGrid, nextGridDim)
	}
	
	// switching rule storage from strings to binary didn't provide much of a speedup
	// in the dictionary lookups so the following is needlessly complicated
	static func readRules(lines:[String]) -> [Int:Int] {
		var dict:[Int:Int] = [:]
		for line in lines {
			if line.count == 0 {
				continue
			}
			let parts = line.components(separatedBy:" => ")
			let rule = parts[0].replacingOccurrences(of:"/", with:"")
			let result = parts[1].replacingOccurrences(of:"/", with:"")
			var resultInt = 0
			for i in 0..<result.count {
				resultInt |= ((result[i] == "#" ? 1 : 0) << i)
			}
			
			var grid:[Bool] = []
			for i in 0..<rule.count {
				grid.append(rule[i] == "#")
			}
			let dim = grid.count == 4 ? 2 : 3
			// for each rule, add all rotations and reflections to the rule dictionary
			for rot in 0...4 {
				for reflX in 0...1 {
					for reflY in 0...1 {
						var ruleInt = 0
						var ruleIntPos = 0
						for y in 0..<dim {
							for x in 0..<dim {
								var x1 = x
								var y1 = y
								if reflX == 1 {
									x1 = dim - 1 - x
								}
								if reflY == 1 {
									y1 = dim - 1 - y
								}
								for _ in 0..<rot {
									let temp = x1
									x1 = dim - 1 - y1
									y1 = temp
								}
								ruleInt |= ((grid[(y1 * dim) + x1] ? 1 : 0) << ruleIntPos)
								ruleIntPos += 1
							}
						}
						// prevent dictionary collisions between 3x3 and 2x2 rules
						if dim == 3 {
							ruleInt |= 65536
						}
						dict[ruleInt] = resultInt
					}
				}
			}
		}
		return dict
	}
	
	static func printGrid(grid:[Bool], gridDim:Int) {
		for y in 0..<gridDim {
			for x in 0..<gridDim {
				print(grid[(y * gridDim) + x] ? "#" : ".", terminator:"")
			}
			print("")
		}
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		let rules = readRules(lines:lines)
		var grid:[Bool] = [ false, true, false,
							false, false, true,
							true, true, true]
		var gridDim = 3
	    for _ in 1...5 {
			(grid, gridDim) = enhance(grid:grid, gridDim:gridDim, rules:rules)
		}
		var part1 = 0
		for i in 0..<grid.count {
			if grid[i] {
				part1 += 1
			}
		}
		print("Part 1:", part1)
		
		for _ in 6...18 {
			(grid, gridDim) = enhance(grid:grid, gridDim:gridDim, rules:rules)
		}
		var part2 = 0
		for i in 0..<grid.count {
			if grid[i] {
				part2 += 1
			}
		}
		print("Part 2:", part2)
	}
}