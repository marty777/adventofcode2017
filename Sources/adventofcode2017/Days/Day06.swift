import Foundation;

class Day06: PuzzleDay {
	
	static func distribute(input:[Int]) -> (Int, Int) {
		var seen:[String:Int] = [:]
		var banks = input
		let start_key = (banks.map{String($0)}).joined(separator: ",")
		seen[start_key] = 1
		var steps = 0
		var part1_steps = 0
		var part2_steps = 0
		var seen_key = ""
		while true {
			steps += 1
			var maxIndex = 0;
			var maxVal = 0;
			for i in 0...banks.count-1 {
				if banks[i] > maxVal {
					maxIndex = i
					maxVal = banks[i]
				}
			}
			banks[maxIndex] = 0
			var index = (maxIndex + 1) % banks.count
			while maxVal > 0 {
				maxVal -= 1
				banks[index] += 1
				index = (index + 1) % banks.count
			}
			let key = (banks.map{String($0)}).joined(separator: ",")
			if seen[key] != nil {
				part1_steps = steps
				seen_key = key
				break
			}
			seen[key] = 1
		}
		steps = 0
		while true {
			steps += 1
			var maxIndex = 0;
			var maxVal = 0;
			for i in 0...banks.count-1 {
				if banks[i] > maxVal {
					maxIndex = i
					maxVal = banks[i]
				}
			}
			banks[maxIndex] = 0
			var index = (maxIndex + 1) % banks.count
			while maxVal > 0 {
				maxVal -= 1
				banks[index] += 1
				index = (index + 1) % banks.count
			}
			let key = (banks.map{String($0)}).joined(separator: ",")
			if key == seen_key {
				part2_steps = steps
				break
			}
		}
		return (part1_steps, part2_steps)
	}
	
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		let line = lines[0]
		let split = line.components(separatedBy:"\t")
		var input:[Int] = []
		for s in split {
			input.append(Int(s)!)
		}
		
		let (part1, part2) = self.distribute(input:input)
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}