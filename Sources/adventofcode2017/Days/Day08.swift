import Foundation;

class Day08: PuzzleDay {
	
	static func execute(lines:[String], registers: inout [String:Int]) -> Int {
		var maxVal = 0
		for line in lines {
			if line.count == 0 {
				continue
			}
			print(line)
			let components = line.components(separatedBy: " ")
			let reg = components[0]
			let op = components[1]
			let amt = Int(components[2])!
			let reg_c = components[4]
			let cond = components[5]
			let amt_c = Int(components[6])!
			print(reg, op, amt, reg_c, cond, amt_c)
			
			if registers[reg] == nil {
				registers[reg] = 0
			}
			if registers[reg_c] == nil {
				registers[reg_c] = 0
			}
			var satisfied = false
			switch(cond) {
				case "==":
					satisfied = (registers[reg_c]! == amt_c)
				case "!=":
					satisfied = (registers[reg_c]! != amt_c)
				case ">=":
					satisfied = (registers[reg_c]! >= amt_c)
				case "<=":
					satisfied = (registers[reg_c]! <= amt_c)
				case ">":
					satisfied = (registers[reg_c]! > amt_c)
				case "<":
					satisfied = (registers[reg_c]! < amt_c)
				default:
					print("Unknown condition \(cond)")
					return -1
			}
			if satisfied {
				if(op == "inc") {
					registers[reg]! += amt
				}
				else {
					registers[reg]! -= amt
				}
				if registers[reg]! > maxVal {
					maxVal = registers[reg]!
				}
			}
			
		}
		return maxVal
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var registers:[String:Int] = [:]
		var part1 = 0
		let part2 = execute(lines:lines, registers:&registers)
		
		for k in registers.keys {
			if registers[k]! > part1 {
				part1 = registers[k]!
			}
		}
		
		
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}