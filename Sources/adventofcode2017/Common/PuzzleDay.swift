
protocol PuzzleDay {
	static func run(inputPath:String)
}

extension PuzzleDay {
	static func readLines(inputPath:String) -> [String] {
		var lines:[String] = []
		do {
			let data = try String(contentsOfFile:inputPath, encoding: String.Encoding.utf8)
			let replaced = data.replacingOccurrences(of:"\r", with:"")
			lines = replaced.components(separatedBy: "\n")
		} catch let err {
			print(err)
		}
		return lines
	}
}