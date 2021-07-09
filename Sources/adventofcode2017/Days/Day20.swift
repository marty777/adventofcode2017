import Foundation;

class Day20: PuzzleDay {
	
	struct Particle {
		var pos_x:Int
		var pos_y:Int
		var pos_z:Int
		var vel_x:Int
		var vel_y:Int
		var vel_z:Int
		var acc_x:Int
		var acc_y:Int
		var acc_z:Int
		var destroyed:Bool
	}
	
	static func dist(_ particle:Particle) -> Int{
		return (abs(particle.pos_x) + abs(particle.pos_y) + abs(particle.pos_z))	
	}
	
	static func update(particles: inout [Particle], part1:Bool) -> (Int, Int) {
		
		var min_dist = -1
		var min_i = -1
		for i in 0..<particles.count {
			if particles[i].destroyed && !part1 {
				continue
			}
			particles[i].vel_x += particles[i].acc_x
			particles[i].vel_y += particles[i].acc_y
			particles[i].vel_z += particles[i].acc_z
			particles[i].pos_x += particles[i].vel_x
			particles[i].pos_y += particles[i].vel_y
			particles[i].pos_z += particles[i].vel_z
			
			let dist = self.dist(particles[i])
			if(min_dist == -1 || dist < min_dist) {
				min_dist = dist
				min_i = i
			}
		}
		var curr_particles = particles.count
		if !part1 {
			for i in 0..<particles.count {
				if particles[i].destroyed {
					continue
				}
				var impact = false
				for j in 0..<particles.count {
					if j == i || particles[j].destroyed {
						continue
					}
					if particles[i].pos_x == particles[j].pos_x && particles[i].pos_y == particles[j].pos_y && particles[i].pos_z == particles[j].pos_z {
						particles[j].destroyed = true
						impact = true
					}
				}
				if impact {
					particles[i].destroyed = true
				}
			}
			curr_particles = 0
			for i in 0..<particles.count {
				if !particles[i].destroyed {
					curr_particles += 1
				}
			}
		}
		return (min_i, curr_particles)
	}
	
	static func run(inputPath:String) {
		let lines = readLines(inputPath:inputPath)
		if(lines.count == 0) {
			return
		}
		
		var particles1:[Particle] = []
		var particles2:[Particle] = []
		for line in lines {
			if line.count == 0 {
				continue
			}
			let components = line.components(separatedBy:", ")
			let pos = components[0].substring(fromIndex:3, toIndex:components[0].count - 1).components(separatedBy:",")
			let vel = components[1].substring(fromIndex:3, toIndex:components[1].count - 1).components(separatedBy:",")
			let acc = components[2].substring(fromIndex:3, toIndex:components[2].count - 1).components(separatedBy:",")
			particles1.append(Particle(  pos_x:Int(pos[0])!, pos_y:Int(pos[1])!, pos_z:Int(pos[2])!, 
										vel_x:Int(vel[0])!, vel_y:Int(vel[1])!, vel_z:Int(vel[2])!,
										acc_x:Int(acc[0])!, acc_y:Int(acc[1])!, acc_z:Int(acc[2])!, destroyed:false ))
			particles2.append(Particle(  pos_x:Int(pos[0])!, pos_y:Int(pos[1])!, pos_z:Int(pos[2])!, 
										vel_x:Int(vel[0])!, vel_y:Int(vel[1])!, vel_z:Int(vel[2])!,
										acc_x:Int(acc[0])!, acc_y:Int(acc[1])!, acc_z:Int(acc[2])!, destroyed:false ))
			
		}
		
		
		// not the most rigorous, but probably right
		var part1 = 0
		var part2 = 0
		let steps = 400
		for _ in 0..<steps {
			(part1, _) = update(particles:&particles1, part1:true)
		}
		for _ in 0..<steps {
			(_, part2) = update(particles:&particles2, part1:false)
		}
		
		print("Part 1:", part1)
		print("Part 2:", part2)
	}
}