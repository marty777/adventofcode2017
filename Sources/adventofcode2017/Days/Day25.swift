import Foundation;

class Day25: PuzzleDay {

	struct TuringInstruction {
		let writeVal:Int
		let delta:Int
		let nextState:String
	}
	
	struct TuringProgram {
		let startState:String
		let checksumSteps:Int
		var states:[String:[TuringInstruction]] = [:]
	}
	
	static func execute(machine:TuringProgram) -> Int {
		var min = 0
		var max = 0
		var index = 0
		var tape:[Int:Bool] = [:]
		var steps = 0
		var state = machine.startState
		var sum = 0
		while(steps < machine.checksumSteps) {
			if tape[index] == nil {
				tape[index] = false
			}
			let currVal = tape[index]! ? 1 : 0
			let newVal = machine.states[state]![currVal].writeVal
			tape[index] = (newVal == 1)
			if currVal == 0 && newVal == 1 {
				sum += 1
			}
			else if currVal == 1 && newVal == 0 {
				sum -= 1
			}
			index += machine.states[state]![currVal].delta
			if index > max {
				max = index
			}
			if index < min {
				min = index
			}
			state = machine.states[state]![currVal].nextState
			steps += 1
		}
		
		return sum
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var program:TuringProgram
		program = TuringProgram(startState:lines[0].substring(fromIndex:"Begin in state ".count, toIndex:lines[0].count - 1),
								checksumSteps:Int(lines[1].substring(fromIndex:"Perform a diagnostic checksum after ".count, toIndex:lines[1].count - 7))!,
								states:[:])
		var i = 3
		while(i < lines.count) {
			var state = lines[i].substring(fromIndex:"In state ".count, toIndex:lines[i].count - 1)
			let write0 = Int(lines[i+2].substring(fromIndex:"    - Write the value ".count, toIndex:lines[i+2].count - 1))!
			let write1 = Int(lines[i+6].substring(fromIndex:"    - Write the value ".count, toIndex:lines[i+6].count - 1))!
			let state0 = lines[i+4].substring(fromIndex:"    - Continue with state ".count, toIndex:lines[i+4].count - 1)
			let state1 = lines[i+8].substring(fromIndex:"    - Continue with state ".count, toIndex:lines[i+8].count - 1)
			let delta0 = (lines[i+3] == "    - Move one slot to the right." ? 1 : -1)
			let delta1 = (lines[i+7] == "    - Move one slot to the right." ? 1 : -1)
			program.states[state] = []
			program.states[state]!.append(TuringInstruction(writeVal:write0, delta:delta0, nextState:state0))
			program.states[state]!.append(TuringInstruction(writeVal:write1, delta:delta1, nextState:state1))
			i += 10
		}
		
		let part1 = execute(machine:program)
		print("Part 1:", part1)
	}
}