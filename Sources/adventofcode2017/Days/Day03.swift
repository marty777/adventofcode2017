import Foundation;

class Day03: PuzzleDay {
	
	static func adjacentSum(map:Dictionary<Coord,Int>, coord:Coord) -> Int {
		var sum = 0
		for i in coord.x - 1...coord.x+1 {
			for j in coord.y - 1...coord.y+1 {
				if i == coord.x && j == coord.y {
					continue
				}
				if map[Coord(x:i,y:j)] != nil {
					sum += map[Coord(x:i,y:j)]!
				}
			}
		}
		return sum
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		let input = Int(lines[0]) ?? -1;
		if(input == -1) {
			print("Couldn't read input \(lines[0])")
			return;
		}
		var part1 = 0
		var part2 = 0
		
		var cornerX = 0
		var cornerY = 0
		var layerDim = 1
		var index = 1
		
		while true {
			if index >= input {
				let diff = index - input
				var inputX = 0
				var inputY = 0
				if diff < layerDim {
					inputY = cornerY
					inputX = cornerX - diff
				}
				else if diff < ((2*layerDim) - 1) {
					inputX = -cornerX
					inputY = cornerY - (diff - (layerDim - 1))
				}
				else if diff < ((3*layerDim) - 2) {
					inputY = -cornerY
					inputX = -cornerX + (diff - (2*(layerDim - 1)))
				}
				else {
					inputX = cornerX
					inputY = -cornerY + (diff - (3*(layerDim - 1)))
				}
				part1 = abs(inputX) + abs(inputY)
				break
			}
			layerDim = layerDim + 2
			cornerX = cornerX + 1
			cornerY = cornerY + 1
			index = index + 4*(layerDim - 1)			
		}
		print("Part 1:", part1)
		
		var map:[Coord:Int] = [Coord(x:0,y:0):1]
		var coord = Coord(x:0,y:0)
		layerDim = 1
		while true {
			coord.x += 1
			layerDim += 2
			for i in 0...(2*layerDim + 2 * (layerDim - 2)) - 1 {
				let offset = i % (layerDim - 1)
				if i < layerDim - 1 {
					coord.x = (layerDim-1)/2
					coord.y = (layerDim-1)/2 - 1 - offset
				}
				else if i < 2*(layerDim - 1) {
					coord.x = ((layerDim-1)/2) - 1 - offset
					coord.y = -(layerDim-1)/2
				}
				else if i < 3*(layerDim - 1) {
					coord.x = -(layerDim-1)/2
					coord.y = -((layerDim-1)/2) + 1 + offset
				}
				else {
					coord.x = -((layerDim-1)/2) + 1 + offset
					coord.y = (layerDim-1)/2
				}
				let val = adjacentSum(map:map, coord:coord)
				if val > input {
					part2 = val
					break
				}
				map[coord] = val
			}
			if part2 > 0 {
				break
			}
		}
		print("Part 2:", part2)
	}
}