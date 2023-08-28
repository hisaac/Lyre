import Foundation
import LyreLib

public enum sw_vers {
	public static func run(
		command: LyreLib.sw_vers.Command
	) async throws -> LyreLib.sw_vers.Output? {
		let task = Process()
		let pipe = Pipe()

		task.standardOutput = pipe
		task.standardError = pipe
		task.arguments = command.arguments
		task.executableURL = command.executableURL
		task.standardInput = nil

		try task.run()

		guard let outputData = try pipe.fileHandleForReading.readToEnd() else { return nil }
		let output = LyreLib.sw_vers.Output.parse(output: outputData, for: command)
		return output
	}
}
