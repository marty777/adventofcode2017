import Foundation;

class Day22: PuzzleDay {
	
	struct Virus {
		var pos:Coord
		var dir:Int // 0 - N, 1 - E, 2 - S, 3 - W
	}
	
	enum MapState {
		case clean
		case weakened
		case infected
		case flagged
	}
	
	static func part1(map: inout[Coord:Bool], virus: inout Virus) -> Int {
		if map[virus.pos] == nil {
			map[virus.pos] = false
		}
		// turn
		if map[virus.pos]! {
			virus.dir = (virus.dir + 1) % 4
		}
		else {
			virus.dir = (virus.dir + 3) % 4
		}
		
		// clean/infect
		var infected = 0
		if !(map[virus.pos]!) {
			infected = 1
		}
		map[virus.pos] = !(map[virus.pos]!)
		
		// move
		switch virus.dir {
			case 0:
				virus.pos.y -= 1
			case 1:
				virus.pos.x += 1
			case 2:
				virus.pos.y += 1
			case 3:
				virus.pos.x -= 1
			default:
				print("invalid direction \(virus.dir)")
		}
		
		return infected
	}
	
	static func part2(map: inout [Coord:MapState], virus:inout Virus) -> Int {
		if map[virus.pos] == nil {
			map[virus.pos] = MapState.clean
		}
		switch map[virus.pos]! {
			case .clean:
				virus.dir = (virus.dir + 3) % 4
			case .weakened:
				break
			case .infected:
				virus.dir = (virus.dir + 1) % 4
			case .flagged:
				virus.dir = (virus.dir + 2) % 4
		}
		
		var infected = 0
		switch map[virus.pos]! {
			case .clean:
				map[virus.pos] = .weakened
			case .weakened:
				map[virus.pos] = .infected
				infected = 1
			case .infected:
				map[virus.pos] = .flagged
			case .flagged:
				map[virus.pos] = .clean
		}
		
		switch virus.dir {
			case 0:
				virus.pos.y -= 1
			case 1:
				virus.pos.x += 1
			case 2:
				virus.pos.y += 1
			case 3:
				virus.pos.x -= 1
			default:
				print("invalid direction \(virus.dir)")
		}
		
		return infected
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var map1:[Coord:Bool] = [:]
		var map2:[Coord:MapState] = [:]
		
		for y in 0..<lines.count {
			if lines[y].count == 0 {
				continue
			}
			for x in 0..<lines[y].count {	
				let coord = Coord(x:x, y:y)
				map1[coord] = (lines[y][x] == "#")
				map2[coord] = (lines[y][x] == "#") ? MapState.infected : MapState.clean
			}
		}
		
		var virus = Virus(pos:Coord(x:(lines[0].count-1)/2, y:(lines.count-1)/2), dir:0)
		var part1 = 0
		for _ in 1...10000 {
			part1 += self.part1(map:&map1, virus:&virus)
		}	
		
		var part2 = 0
		virus.dir = 0
		virus.pos.x = (lines[0].count-1)/2
		virus.pos.y = (lines.count-1)/2
		for _ in 1...10000000 {
			part2 += self.part2(map:&map2, virus:&virus)
		}
		
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}