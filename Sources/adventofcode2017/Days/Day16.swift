import Foundation;

class Day16: PuzzleDay {
	
	struct DanceOrder {
		var startIndex:Int
		var dancers:[Int]
	}
	
	struct DanceMove {
		var inst:Int
		var arg1:Int
		var arg2:Int
	}
	
	static func spin(danceOrder: inout DanceOrder, size:Int) {
		danceOrder.startIndex = (danceOrder.startIndex - size) % danceOrder.dancers.count
		if danceOrder.startIndex < 0 {
			danceOrder.startIndex = (danceOrder.startIndex + danceOrder.dancers.count) % danceOrder.dancers.count
		}
	}
	
	static func exchange(danceOrder: inout DanceOrder, positionA:Int, positionB:Int) {
		let posA = (positionA + danceOrder.startIndex) % danceOrder.dancers.count
		let posB = (positionB + danceOrder.startIndex) % danceOrder.dancers.count
		let temp = danceOrder.dancers[posA]
		danceOrder.dancers[posA] = danceOrder.dancers[posB]
		danceOrder.dancers[posB] = temp
	}
	
	static func partner(danceOrder: inout DanceOrder, partnerA:Int, partnerB:Int) {
		var posA = -1
		var posB = -1
		for i in 0..<danceOrder.dancers.count {
			if danceOrder.dancers[i] == partnerA {
				posA = i
			}
			else if danceOrder.dancers[i] == partnerB {
				posB = i
			}
		}
		if posA == -1 || posB == -1 {
			print("An error occured locating dancers \(partnerA) and \(partnerB) on exchange")
			return
		}
		let temp = danceOrder.dancers[posA]
		danceOrder.dancers[posA] = danceOrder.dancers[posB]
		danceOrder.dancers[posB] = temp
	}
	
	static func danceOrderString(danceOrder:DanceOrder) -> String {
		var ret:String = ""
		for i in 0..<danceOrder.dancers.count {
			let index = (danceOrder.startIndex + i) % danceOrder.dancers.count
			let c = Character(UnicodeScalar(97 + danceOrder.dancers[index])!)
			ret += String(c)
		}
		return ret;
	}
	
	static func executeDance(danceOrder: inout DanceOrder, moves:[DanceMove]) {
		for m in moves {
			switch m.inst {
				case 0:
					spin(danceOrder: &danceOrder, size:m.arg1)
				case 1:
					exchange(danceOrder: &danceOrder, positionA:m.arg1, positionB:m.arg2)
				case 2:
					partner(danceOrder: &danceOrder, partnerA:m.arg1, partnerB:m.arg2)
				default:
					print("Unknown dance move found \(m.inst)")
					return
			}
		}
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		let dancers = 16
		var danceOrder = DanceOrder(startIndex:0, dancers:[])
		for i in 0..<dancers {
			danceOrder.dancers.append(i)
		}
		
		let moves = lines[0].components(separatedBy:",")
		var danceMoves:[DanceMove] = []
		for m in moves {
			if m[0] == "s" {				
				let amt = Int(m.substring(fromIndex:1))!
				let d = DanceMove(inst:0, arg1:amt, arg2:-1)
				danceMoves.append(d)
			}
			else if m[0] == "x" {
				let substr = m.substring(fromIndex:1)
				let parts = substr.components(separatedBy:"/")
				let d = DanceMove(inst:1, arg1:Int(parts[0])!, arg2:Int(parts[1])!)
				danceMoves.append(d)
			}
			else if m[0] == "p" {
				let substr = m.substring(fromIndex:1)
				let parts = substr.components(separatedBy:"/")
				let arg1 = Int(Character(parts[0]).asciiValue! - 97)
				let arg2 = Int(Character(parts[1]).asciiValue! - 97)
				let d = DanceMove(inst:2, arg1:arg1, arg2:arg2)
				danceMoves.append(d)
			}
			else {
				print("Unknown move found \(m)")
			}
		}
		executeDance(danceOrder: &danceOrder, moves:danceMoves)
		let part1 = danceOrderString(danceOrder:danceOrder)
		print("Part 1:", part1)
		
		var cycleLength = -1
		for i in 1..<1_000_000_000 {		
			executeDance(danceOrder: &danceOrder, moves:danceMoves)
			if danceOrderString(danceOrder:danceOrder) == part1 {
				cycleLength = i
				break
			}
		}
		// either we found a cycle or we ran through a billion iterations and are done
		if cycleLength != -1 {
			let dances = (1_000_000_000 - 1) % cycleLength
			for _ in 0..<dances {
				executeDance(danceOrder: &danceOrder, moves:danceMoves)
			}
		}
		let part2 = danceOrderString(danceOrder:danceOrder)
		print("Part 2:", part2)
	}
}