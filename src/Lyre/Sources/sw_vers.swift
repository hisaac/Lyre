import Foundation
import LyreKit

public enum sw_vers {
	public static func run(
		command: LyreKit.sw_vers.Command
	) async throws -> LyreKit.sw_vers.Output? {
		let result = try await ShellCommand.run(
			executableURL: command.executableURL,
			arguments: command.arguments
		)

		if let error = result.error {
			throw error
		}

		let rawOutput = try result.utf8Output()
		let output = LyreKit.sw_vers.Output.parse(output: rawOutput, for: command)
		return output
	}
}
