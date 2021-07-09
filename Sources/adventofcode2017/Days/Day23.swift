import Foundation;

class Day23: PuzzleDay {
	
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
	
	static func executeOne(instructions:[String], registers: inout [String:Int], index: inout Int, part1:Bool) {
		
		let components = instructions[index].components(separatedBy:" ")
		switch components[0] {
			case "set":
				registers[components[1]] = val(registers:&registers, value:components[2])
				index += 1
			case "add":
				if registers[components[1]] == nil {
					registers[components[1]] = 0
				}
				registers[components[1]]! += val(registers:&registers, value:components[2])
				index += 1
			case "sub":
				if registers[components[1]] == nil {
					registers[components[1]] = 0
				}
				registers[components[1]]! -= val(registers:&registers, value:components[2])
				index += 1
			case "mul":
				if registers[components[1]] == nil {
					registers[components[1]] = 0
				}
				registers[components[1]]! *= val(registers:&registers, value:components[2])
				if part1 {
					registers["mul"]! += 1
				}
				index += 1
			case "jnz":
				if val(registers:&registers, value:components[1]) != 0 {
					index += val(registers:&registers, value:components[2])
				}
				else {
					index += 1
				}
			default:
				print("Unrecognized instruction at index \(index): \(instructions[index])")
				index = -1
		}
	}
	
	// far from efficient but good enough
	static func isPrime(_ x:Int) -> Bool {
		if x <= 1 {
			return false
		}
		if x == 2 || x == 3 {
			return true
		}
		var i = 2
		let sqrt = Double(x).squareRoot()
		while Double(i) < sqrt {
			if x % i == 0 {
				return false
			}
			i += 1
		}
		return true
	}
	
	// Ah heck, it's counting non-primes in a range of integers. Weird.
	// Anyway, extract the useful values from the instructions. This 
	// implementation is dependant on the layout of my input file and 
	// may not be guaranteed to work for others.
	static func part2(lines:[String]) -> Int {
		var instructions:[String] = []
		for l in lines {
			if l.count > 0 {
				instructions.append(l)
			}
		}
		// determine the values
		var b = 0
		var c = 0
		b = Int(instructions[0].components(separatedBy:" ")[2])!
		b *= Int(instructions[4].components(separatedBy:" ")[2])!
		b -= Int(instructions[5].components(separatedBy:" ")[2])!
		
		c = b
		c -= Int(instructions[7].components(separatedBy:" ")[2])!
		
		let increment = -Int(instructions[instructions.count - 2].components(separatedBy:" ")[2])!
		
		var h = 0
		var i = b
		while i <= c {
			if !isPrime(i) {
				h += 1
			}
			i += increment
		}
		
		return h
	}
	
	static func part1(lines:[String]) -> Int {
		var instructions:[String] = []
		for l in lines {
			if l.count > 0 {
				instructions.append(l)
			}
		}
		var registers:[String:Int] = [:]
		registers["mul"] = 0
		var index = 0
		while index >= 0 && index < instructions.count {
			executeOne(instructions:instructions, registers:&registers, index: &index, part1:true )
		}
		return registers["mul"] ?? 0
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