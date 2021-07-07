import Foundation;

class Day18: PuzzleDay {
	
	static func val(registers:inout [String:Int], value:String) -> Int {
		// if a register
		if value.count == 1 && Character(value).asciiValue! >= 97 && Character(value).asciiValue! <= 122 {
			if registers[value] == nil {
				registers[value] = 0
			}
			return registers[value]!
		}
		return Int(value)!
	}
	
	// returns 0 for ready, 1 for blocking, 2 for exit
	static func executeOne(instructions:[String], registers: inout [String:Int], index: inout Int, send: inout [Int], receive: inout [Int], part1:Bool) -> Int {
		if index < 0 || index >= instructions.count {
			return 2
		}
		let components = instructions[index].components(separatedBy:" ")
		switch components[0] {
			case "snd":
				if part1 {
					registers["snd"] = val(registers:&registers, value:components[1])
				}
				else {
					send.append(val(registers:&registers, value:components[1]))
					registers["sent"]! += 1
				}
				index += 1
			case "set":
				registers[components[1]] = val(registers:&registers, value:components[2])
				index += 1
			case "add":
				if registers[components[1]] == nil {
					registers[components[1]] = 0
				}
				registers[components[1]]! += val(registers:&registers, value:components[2])
				index += 1
			case "mul":
				if registers[components[1]] == nil {
					registers[components[1]] = 0
				}
				registers[components[1]]! *= val(registers:&registers, value:components[2])
				index += 1
			case "mod":
				if registers[components[1]] == nil {
					registers[components[1]] = 0
				}
				registers[components[1]]! %= val(registers:&registers, value:components[2])
				index += 1
			case "rcv":
				if part1 {
					if val(registers:&registers, value:components[1]) != 0 {
						if registers["snd"] == nil {
							registers["snd"] = 0
						}
						registers["rcv"] = registers["snd"]!
					}
					index += 1
				}
				else {
					if receive.count > 0 {
						registers[components[1]] = receive[0]
						receive.removeFirst(1)
						index += 1
					}
					else {
						return 1
					}
				}
			case "jgz":
				if val(registers:&registers, value:components[1]) > 0 {
					index += val(registers:&registers, value:components[2])
				}
				else {
					index += 1
				}
			default:
				print("Unrecognized instruction at index \(index): \(instructions[index])")
				index = -1
				return 2
		}
		return 0
	}
	
	static func part2(lines:[String]) -> Int {
		// filter out blank lines in input
		var instructions:[String] = []
		for l in lines {
			if l.count > 0 {
				instructions.append(l)
			}
		}
		
		var registersA:[String:Int] = [:]
		registersA["sent"] = 0
		registersA["p"] = 0
		var registersB:[String:Int] = [:]
		registersB["sent"] = 0
		registersB["p"] = 1
		var channelA:[Int] = []
		var channelB:[Int] = []
		var indexA = 0
		var indexB = 0
		while true {
			var countA = 0
			var countB = 0
			while true {
				if executeOne(instructions:instructions, registers: &registersA, index:&indexA, send: &channelA, receive: &channelB, part1:false) != 0 {
					break
				}
				countA += 1
			}
			while true {
				if executeOne(instructions:instructions, registers: &registersB, index:&indexB, send: &channelB, receive: &channelA, part1:false) != 0 {
					break
				}
				countB += 1
			}
			
			if (countA == 0 && countB == 0) {
				break
			}
		}
		return registersB["sent"]!
	}
	
	static func part1(lines:[String]) -> Int {
		var instructions:[String] = []
		for l in lines {
			if l.count > 0 {
				instructions.append(l)
			}
		}
		var registers:[String:Int] = [:]
		registers["snd"] = 0
		var send:[Int] = []
		var receive:[Int] = []
		var index = 0
		while index >= 0 && index < instructions.count {
			_ = executeOne(instructions:instructions, registers:&registers, index: &index, send: &send, receive:&receive, part1:true )
			if registers["rcv"] != nil {
				break
			}
		}
		return registers["rcv"] ?? 0
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		let part1 = self.part1(lines:lines)
		let part2 = self.part2(lines:lines)
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}