import ArgumentParser
import Foundation
import LyreKit

@main
struct LyreBird: AsyncParsableCommand {
	static let version = "1.0.0-alpha"

	static var configuration = CommandConfiguration(
		commandName: "lb",
		version: version,
		subcommands: [
			sw_vers.self,
		]
	)
}
