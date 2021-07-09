import Foundation;

class Day19: PuzzleDay {
	
	
	static func traverse(_ grid:[[Character]]) -> (String, Int) {
		let height = grid.count
		let width = grid[0].count
		var curr_pos:Coord = Coord(x:0,y:0)
		var curr_dir = 2 // 0 N, 1 E, 2 S, 3 W
		while curr_pos.x < width {
			if grid[curr_pos.y][curr_pos.x] == "|" {
				break
			}
			curr_pos.x += 1
		}
		var collection:[Character] = []
		var steps = 0
		while true {
			var next_pos = Coord(x:curr_pos.x, y:curr_pos.y)
			var done = false
			switch curr_dir {
				case 0:
					next_pos.y -= 1
				case 1:
					next_pos.x += 1
				case 2:
					next_pos.y += 1
				case 3:
					next_pos.x -= 1
				default:
					print("Error with current direction \(curr_dir)")
					return ("", -1)
			}
			if next_pos.y < 0 || next_pos.y >= height || next_pos.x < 0 || next_pos.x >= width || grid[next_pos.y][next_pos.x] == " " {
				done = true
				if curr_dir == 0 || curr_dir == 2 {
					if curr_pos.x > 0 && grid[curr_pos.y][curr_pos.x - 1] != " " {
						curr_dir = 3
						next_pos.y = curr_pos.y
						next_pos.x = curr_pos.x - 1
						done = false
					}
					else if curr_pos.x < width && grid[curr_pos.y][curr_pos.x + 1] != " " {
						curr_dir = 1
						next_pos.y = curr_pos.y
						next_pos.x = curr_pos.x + 1
						done = false
					}
				}
				else if curr_dir == 1 || curr_dir == 3 {
					if curr_pos.y > 0 && grid[curr_pos.y - 1][curr_pos.x] != " " {
						curr_dir = 0
						next_pos.y = curr_pos.y - 1
						next_pos.x = curr_pos.x 
						done = false
					}
					else if curr_pos.y < height && grid[curr_pos.y + 1][curr_pos.x] != " " {
						curr_dir = 2
						next_pos.y = curr_pos.y + 1
						next_pos.x = curr_pos.x
						done = false
					}
				}
			}
			if grid[curr_pos.y][curr_pos.x].isLetter {
				collection.append(grid[curr_pos.y][curr_pos.x])
			}
			if done {
				break
			}
			curr_pos = next_pos
			steps += 1
		}
		
		return (String(collection), steps + 1)
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var grid:[[Character]] = []
		for line in lines {
			if line.count == 0 {
				continue
			}
			let row = Array(line)
			grid.append(row)
		}
		
		let (part1, part2) = traverse(grid)
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}