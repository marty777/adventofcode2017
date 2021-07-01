import XCTest
import Foundation

class adventofcode2017Tests: XCTestCase {
	
	func runInput(day:Int,inputPath:String) -> [String] {
		// the wrapper around the test automatically generated by the 
		// package builder suggests this won't work outside of OS X 13.
		// I'm running in a Linux container under Windows, and it seeems 
		// to work okay, but who knows...
		let binary = productsDirectory.appendingPathComponent("adventofcode2017")

		let process = Process()
		process.executableURL = binary

		let pipe = Pipe()
		process.standardOutput = pipe
		process.arguments = ["adventofcode2017", String(day), inputPath];
		do {
			try process.run()
			process.waitUntilExit()
			let data = pipe.fileHandleForReading.readDataToEndOfFile()
			let output = String(data: data, encoding: .utf8)!
			let lines = output.components(separatedBy:"\n")
			return lines;
		} catch {
			let lines:[String] = []
			return lines
		}
		
	}
	
	func testDay01() throws {
		
		let lines = runInput(day:1, inputPath:"./Tests/TestData/Day01/sample.txt")
		
		XCTAssertEqual(lines[lines.count - 4], "Part 1: 9")
		XCTAssertEqual(lines[lines.count - 3], "Part 2: 6")
	}
	
	func testDay02() throws {
		let lines = runInput(day:2, inputPath:"./Tests/TestData/Day02/sample.txt")
		
		XCTAssertEqual(lines[lines.count - 4], "Part 1: 18")
		XCTAssertEqual(lines[lines.count - 3], "Part 2: 8")
	}
	
	func testDay03() throws {
		let lines = runInput(day:3, inputPath:"./Tests/TestData/Day03/sample.txt")
		
		XCTAssertEqual(lines[lines.count - 4], "Part 1: 31")
		XCTAssertEqual(lines[lines.count - 3], "Part 2: 1968")
	}
	
	func testDay04() throws {
		let lines1 = runInput(day:4, inputPath:"./Tests/TestData/Day04/sample1.txt")
		XCTAssertEqual(lines1[lines1.count - 4], "Part 1: 2")
		
		let lines2 = runInput(day:4, inputPath:"./Tests/TestData/Day04/sample2.txt")
		XCTAssertEqual(lines2[lines2.count - 3], "Part 2: 3")
	}

	func testDay05() throws {
		let lines = runInput(day:5, inputPath:"./Tests/TestData/Day05/sample.txt")
		
		XCTAssertEqual(lines[lines.count - 4], "Part 1: 5")
		XCTAssertEqual(lines[lines.count - 3], "Part 2: 10")
	}
	
	func testDay06() throws {
		let lines = runInput(day:6, inputPath:"./Tests/TestData/Day06/sample.txt")
		
		XCTAssertEqual(lines[lines.count - 4], "Part 1: 5")
		XCTAssertEqual(lines[lines.count - 3], "Part 2: 4")
	}
	
	func testDay07() throws {
		let lines = runInput(day:7, inputPath:"./Tests/TestData/Day07/sample.txt")
		
		XCTAssertEqual(lines[lines.count - 4], "Part 1: tknk")
		XCTAssertEqual(lines[lines.count - 3], "Part 2: 60")
	}
	
	/// Returns path to the built products directory.
	var productsDirectory: URL {
	  #if os(macOS)
		for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
			return bundle.bundleURL.deletingLastPathComponent()
		}
		fatalError("couldn't find the products directory")
	  #else
		return Bundle.main.bundleURL
	  #endif
	}
}
