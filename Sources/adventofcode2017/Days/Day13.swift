import Foundation;

class Day13: PuzzleDay {
	
	static func gcd(x: Int, y: Int) -> Int {
		var a = 0
		var b = max(x, y)
		var r = min(x, y)
		while r != 0 {
			a = b
			b = r
			r = a % b
		}
		return b
	}
	
	static func lcm(x: Int, y: Int) -> Int {
		return x / gcd(x:x, y:y) * y
	}
	
	static func part1(layers:[Int:Int]) -> Int {
		var sum = 0
		var maxLayer = 0
		for k in layers.keys {
			if k > maxLayer {
				maxLayer = k
			}
		}
		for i in 0...maxLayer {
			if layers[i] == nil {
				continue
			}
			if (i) % (layers[i]!) == 0 {
				sum += i * (layers[i]!/2 + 1)
			}
		}
		return sum
	}
	
	static func part2(layers:[Int:Int]) -> Int {
		// sieving
		var lcm = layers[0]!
		for k in layers.keys {
			let l = layers[k]!
			lcm = self.lcm(x:lcm,y:l)
		}
		var sieve = [Bool](repeating:false, count:lcm)
		for k in layers.keys {
			let len = layers[k]!
			var index = (len - k) % len
			if index < 0 {
				index += len
			}
			while index < lcm {
				sieve[index] = true
				index += len
			}
		}
		for i in 0..<lcm {
			if !sieve[i] {
				return i
			}
		}
		return -1
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var layers:[Int:Int] = [:]
		for line in lines {
			if line.count == 0 {
				continue
			}
			let parts = line.components(separatedBy:": ")
			let len = Int(parts[1])!
			layers[Int(parts[0])!] = (len - 1)*2 // actual length of the cycle
		}
		
		let part1 = self.part1(layers:layers)
		print("Part 1:", part1)
		let part2 = self.part2(layers:layers)
		print("Part 2:", part2)
	}
}