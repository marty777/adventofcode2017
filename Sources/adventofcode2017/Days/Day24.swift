import Foundation;

class Day24: PuzzleDay {
	
	struct Component {
		var a:Int
		var b:Int
	}
	
	static func recurse(components:[Component], used:[Bool], chain:[Int], level:Int, part2:Bool) -> (Int,Int) {
		var prev:Int
		if chain.count == 0 {
			prev = 0
		}
		else {
			prev = chain.last!
		}
		var bestLength = chain.count/2
		var bestStrength = 0
		for c in chain {
			bestStrength += c
		}
		for i in 0..<components.count {
			if (components[i].a == prev || components[i].b == prev) && !used[i] {
				var nextChain = chain
				var nextUsed = used
				nextUsed[i] = true
				if components[i].a == prev {
					nextChain.append(components[i].a)
					nextChain.append(components[i].b)
				}
				else {
					nextChain.append(components[i].b)
					nextChain.append(components[i].a)
				}
				let (resultLength, resultStrength) = recurse(components:components, used:nextUsed, chain:nextChain, level:level+1, part2:part2)
				if part2 {
					if resultLength > bestLength || (resultLength == bestLength && resultStrength > bestStrength) {
						bestLength = resultLength
						bestStrength = resultStrength
					}
				}
				else {
					if(resultStrength > bestStrength) {
						bestStrength = resultStrength
						bestLength = resultLength
					}
				}
			}
		}
		return (bestLength, bestStrength)
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var components:[Component] = []
		for line in lines {
			if line.count == 0 {
				continue
			}
			let split = line.components(separatedBy:"/")
			components.append(Component(a:Int(split[0])!, b:Int(split[1])!))
		}
		let used = [Bool](repeating:false,count:components.count)
		let (_,part1) = recurse(components:components, used:used, chain:[], level:0, part2:false)
		let (_,part2) = recurse(components:components, used:used, chain:[], level:0, part2:true)
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}