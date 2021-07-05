/*
Advent of Code 2017 in Swift 5.4
*/

import Foundation

func usage() {
	print("Usage:")
	print("swift run adventofcode2017 [DAY] [INPUT FILE PATH]")
	for argument in CommandLine.arguments {
		print(argument)
	}
}

func cliargs(maxday:Int) -> (Int, String) {
	var clDay = -1
	var clPath = ""
	var clArgCount = 0
	for argument in CommandLine.arguments {
		if argument.contains("adventofcode2017") {
			continue
		}
		clArgCount+=1;
		if clArgCount == 1 {
			clDay = Int(argument) ?? -1
		}
		else if clArgCount == 2 {
			clPath = argument
		}
	}
	if clArgCount > 1 {
		if clDay < 1 || clDay > maxday || !FileManager.default.fileExists(atPath:clPath) {
			usage()
			exit(0)
		}
		return (clDay, clPath)
	}
	else {
		return (-1, "")
	}
}

func interactive(maxday:Int, maxfiles:Int) -> (Int, String) {
	let dataDir = "./Data/"
	let resetCode = ["\u{001B}[0m", ""]
	let cyanCode = ["\u{001B}[36m", "\u{001B}[0m"]
	let yellowCode = ["\u{001B}[33m", "\u{001B}[0m"]
	print(resetCode[0] + cyanCode[0] + "-----------------------------------------------------------------------------" + resetCode[0])
	print(yellowCode[0] + "    _      _             _          __    ___         _       ___ __  _ ____ ")
	print("   /_\\  __| |_ _____ _ _| |_   ___ / _|  / __|___  __| |___  |_  )  \\/ |__  |")
	print("  / _ \\/ _` \\ V / -_) ' \\  _| / _ \\  _| | (__/ _ \\/ _` / -_)  / / () | | / /") 
	print(" /_/ \\_\\__,_|\\_/\\___|_||_\\__| \\___/_|    \\___\\___/\\__,_\\___| /___\\__/|_|/_/ " + resetCode[0])
	print(cyanCode[0] + "-----------------------------------------------------------------------------" + resetCode[0])
	// get day to run from stdin
	var day:Int? = nil
	while(day == nil) {
		print("Enter day to run (1-\(maxday)): ", terminator:"")
		day = Int(readLine()!)
		if day == nil || day! < 1 || day! > maxday{
			day = nil
		}
	}
	// locate data dir and display input files to run
	let fileManager = FileManager.default
	let dayDataDir = dataDir + "Day" + (day! < 10 ? "0" : "") + String(day!)
	do {
		let dirItems = try fileManager.contentsOfDirectory(atPath:dayDataDir)
		if(dirItems.count == 0) {
			print("No input files available in \(dayDataDir)")
			exit(0)
		}
		if(dirItems.count > maxfiles) {
			print("Displaying first \(maxfiles) input files in \(dayDataDir):")
		}
		else {
			print("Available input files in \(dayDataDir):")
		}
		var i = 0
		while(i < dirItems.count && i < maxfiles) {
			print("\t\(i+1)) \(dirItems[i])")
			i+=1
		}
		var inputIndex:Int? = nil
		let maxInput = dirItems.count > maxfiles ? maxfiles : dirItems.count
		while(inputIndex == nil) {
			print("Enter the index of the input file to read (1-\(maxInput)): ", terminator:"")
			inputIndex = Int(readLine()!)
			if(inputIndex! < 1 || inputIndex! > maxInput) {
				inputIndex = nil
			}
		}
		
		return (day!, dayDataDir + "/" + dirItems[inputIndex! - 1]);
	}
	catch {
		print("Could not read from a directory at \(dayDataDir)")
		exit(0)
	}
}

let maxday = 14
let maxfiles = 9
var day = -1
var path = ""
// i got all fancy with an interactive terminal mode, but for testing simplicity i'm adding a more direct mode
// launched with command line arguments
(day, path) = cliargs(maxday:maxday);
if(day == -1) {
	(day, path) = interactive(maxday:maxday, maxfiles:maxfiles);
}
if(day < 1 || day > maxday || !FileManager.default.fileExists(atPath:path)) {
	usage()
	exit(0)
}
let yellowCode = ["\u{001B}[33m", "\u{001B}[0m"]
print("Running Day \(day) with input file \(path)")
let startTime = DispatchTime.now()
switch day {
	case 1:
		Day01.run(inputPath: path)
	case 2:
		Day02.run(inputPath: path)
	case 3:
		Day03.run(inputPath: path)
	case 4:
		Day04.run(inputPath: path)
	case 5:
		Day05.run(inputPath: path)
	case 6:
		Day06.run(inputPath: path)
	case 7:
		Day07.run(inputPath: path)
	case 8:
		Day08.run(inputPath: path)
	case 9:
		Day09.run(inputPath: path)
	case 10:
		Day10.run(inputPath: path)
	case 11:
		Day11.run(inputPath: path)
	case 12:
		Day12.run(inputPath: path)
	case 13:
		Day13.run(inputPath: path)
	case 14:
		Day14.run(inputPath: path)
	default:
		print("Something went wrong!")
		exit(0)
}
let endTime = DispatchTime.now()
let ns = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
let elapsed = Int(Double(ns) / 1000000)
print(yellowCode[0] + "Elapsed time: \(elapsed) ms" + yellowCode[1]);
