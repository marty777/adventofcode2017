import Foundation;

class Day24: PuzzleDay {
	
	struct Component {
		var a:Int
		var b:Int
	}
	
	static func recurse(components:[Component], used:[Bool], chain:[Int], level:Int) -> Int {
		var prev:Int
		if chain.count == 0 {
			prev = 0
		}
		else {
			prev = chain.last!
		}
		var best = 0
		for c in chain {
			best += c
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
				let result = recurse(components:components, used:nextUsed, chain:nextChain, level:level+1)
				if result > best {
					best = result
				}
			}
		}
		return best
	}
	
	static func recurse2(components:[Component], used:[Bool], chain:[Int], level:Int) -> (Int,Int) {
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
				let (resultLength, resultStrength) = recurse2(components:components, used:nextUsed, chain:nextChain, level:level+1)
				if resultLength > bestLength || (resultLength == bestLength && resultStrength > bestStrength) {
					bestLength = resultLength
					bestStrength = resultStrength
					//print(level, nextChain, "\t", bestLength, bestStrength)
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
		let part1 = recurse(components:components, used:used, chain:[], level:0)
		let( _,part2) = recurse2(components:components, used:used, chain:[], level:0)
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}