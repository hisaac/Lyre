import Foundation
import LyreLib

public enum sw_vers {
	public static func run(command: sw_versCommand) async throws -> sw_versOutput? {
		let task = Process()
		let pipe = Pipe()

		task.standardOutput = pipe
		task.standardError = pipe
		task.arguments = command.arguments
		task.executableURL = command.executableURL
		task.standardInput = nil

		try task.run()

		guard let outputData = try pipe.fileHandleForReading.readToEnd() else { return nil }
		let output = sw_versOutput.parse(output: outputData, for: command)
		return output
	}
}
