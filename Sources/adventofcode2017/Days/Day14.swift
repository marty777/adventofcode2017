import Foundation;

class Day14: PuzzleDay {
	
	static func reverse(nodes: inout [Int], startIndex:Int, length:Int) {
		var stack:[Int] = []
		for i in 0..<length {
			let index = (startIndex + i) % nodes.count
			stack.append(nodes[index])
		}
		for i in 0..<length {
			let index = (startIndex + i) % nodes.count
			nodes[index] = stack[stack.count - 1 - i]
		}
	}
	
	static func round(nodes: inout [Int], lengths:[Int], index: inout Int, skipSize: inout Int) {
		for length in lengths {
			reverse(nodes: &nodes, startIndex:index, length:length)
			index = (index + length + skipSize) % nodes.count
			skipSize += 1
		}
	}
	
	static func reduceToBinary(nodes:[Int]) -> [Bool] {
		assert(nodes.count == 256, "incorrect number of nodes: \(nodes.count)")
		var ret:[Bool] = []
		var accumulator:Int
		for i in 0..<16 {
			accumulator = 0
			for j in 0..<16 {
				accumulator ^= nodes[16*i + j]
			}
			for j in 0...7 {
				let test = ((accumulator >> (7-j)) & 0x1)
				ret.append(test == 1)
			}
		}
		return ret
	}
	
	static func knotHash(input:String) -> [Bool] {
		let numNodes = 256
		var lengths:[Int] = []
		let inputArr = Array(input)
		for c in inputArr {
			let ascii = Int(c.asciiValue!)
			lengths.append(ascii)
		}
		lengths.append(contentsOf:[17,31,73,47,23])
		
		var nodes:[Int] = []
		for i in 0..<numNodes {
			nodes.append(i)
		}
		var skipSize = 0
		var index = 0
		for _ in 0..<64 {
			round(nodes:&nodes, lengths:lengths, index:&index, skipSize:&skipSize)
		}
		return reduceToBinary(nodes:nodes)
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		let key = lines[0]
		var part1 = 0
		var rows:[[Bool]] = []
		var assignments:[[Int]] = []
		var groupIndex = 0
		for i in 0...127 {
			let row = knotHash(input:"\(key)-\(i)")
			for j in row {
				if j == true {
					part1 += 1
				}
			}
			rows.append(row)
			assignments.append([Int](repeating:-1,count:128))
		}
		// flood fill
		for y in 0...127 {
			for x in 0...127 {
				if !rows[y][x] {
					continue
				}
				if assignments[y][x] != -1 {
					continue
				}
				var stack:[Coord] = [Coord(x:x,y:y)]
				groupIndex += 1
				while stack.count > 0 {
					let coord = stack.removeLast()
					// n
					if coord.y > 0 && rows[coord.y-1][coord.x] && assignments[coord.y-1][coord.x] == -1 {
						stack.append(Coord(x:coord.x, y:coord.y-1))
					}
					// s
					if coord.y < 127 && rows[coord.y+1][coord.x] && assignments[coord.y+1][coord.x] == -1{
						stack.append(Coord(x:coord.x, y:coord.y+1))
					}
					// w
					if coord.x > 0 && rows[coord.y][coord.x-1] && assignments[coord.y][coord.x-1] == -1 {
						stack.append(Coord(x:coord.x-1, y:coord.y))
					}
					// e
					if coord.x < 127 && rows[coord.y][coord.x+1] && assignments[coord.y][coord.x+1] == -1 {
						stack.append(Coord(x:coord.x+1, y:coord.y))
					}
					assignments[coord.y][coord.x] = groupIndex
				}
			}
		}
		let part2 = groupIndex
		
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}