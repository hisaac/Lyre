import ArgumentParser
import Foundation
import LyreKit

@main
struct LyreBirdCLI: AsyncParsableCommand {
	static let version = "1.0.0-alpha"

	static var configuration = CommandConfiguration(
		commandName: "lb",
		version: version,
		subcommands: [
			sw_versCommand.self
		]
	)
}

struct sw_versCommand: AsyncParsableCommand {
	static var configuration = CommandConfiguration(commandName: "sw_vers")

	@Argument(parsing: .captureForPassthrough)
	var args: [String] = []

	func run() async throws {
		let output = try await LyreKit.sw_vers.run(args: args)
		print(output.raw)
	}
}
