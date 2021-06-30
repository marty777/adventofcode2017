
struct Coord {
	var x: Int
	var y: Int
}
	
extension Coord: Hashable {
	static func == (lhs: Coord, rhs: Coord) -> Bool {
		return lhs.x == rhs.x && lhs.y == rhs.y
	}
	func hash(into hasher: inout Hasher) {
		hasher.combine(x)
		hasher.combine(y)
	}
}
	