import ArgumentParser
import Foundation
import LyreLib
import SwiftSlash

public enum sw_vers {
	public static var defaultLocation: URL {
		URL(filePath: "/usr/bin/sw_vers")
	}

	public static func run(
		_ path: URL = defaultLocation,
		args: [String]
	) async throws -> sw_versOutput {
		let command = try sw_versCommand.parse(args)
		return try await command.run(path)
	}
}

extension sw_versCommand {
	public func run(_ path: URL) async throws -> sw_versOutput {
		let shellCommand = Command(
			executableURL: path,
			arguments: args
		)

		let processInterface = ProcessInterface(command: shellCommand)
		try await processInterface.launch()

		let exitCode = ExitCode(try await processInterface.exitCode())
		guard exitCode.isSuccess else { throw exitCode }

		var stdoutData = Data()
		for await stdoutChunk in await processInterface.stdout {
			stdoutData.append(stdoutChunk)
		}

		guard let output = try sw_versOutput.parse(output: stdoutData) else { throw exitCode }
		return output
	}
}
