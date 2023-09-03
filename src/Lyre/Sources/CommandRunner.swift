import Foundation
import TSCBasic

public enum ShellCommand {
	public static func run(
		executableURL: URL,
		arguments: [String] = [],
		input: Data? = nil,
		environment: [String: String] = ProcessInfo().environment,
		workingDirectory: URL = URL(filePath: FileManager.default.currentDirectoryPath),
		printOutput: Bool = false
	) async throws -> ProcessResult {
		var arguments = arguments
		arguments.insert(executableURL.path(), at: 0)

		let outputRedirection: TSCBasic.Process.OutputRedirection
		if printOutput {
			outputRedirection = .stream(
				stdout: { bytes in
					FileHandle.standardOutput.write(Data(bytes))
				},
				stderr: { bytes in
					FileHandle.standardError.write(Data(bytes))
				}
			)
		} else {
			outputRedirection = .collect
		}

		let process = try TSCBasic.Process(
			arguments: arguments,
			environment: environment,
			workingDirectory: AbsolutePath(validating: workingDirectory.path()),
			outputRedirection: outputRedirection,
			startNewProcessGroup: false
		)

		try process.launch()
		let result = try await process.waitUntilExit()

		return result
	}
}

extension ProcessResult {
	var exitCode: Int32 {
		exitStatus.code
	}

	var succeeded: Bool {
		exitCode == 0
	}

	var failed: Bool {
		exitCode != 0
	}

	var error: Error? {
		guard failed else { return nil }
		return ProcessResult.Error.nonZeroExit(self)
	}
}

extension ProcessResult.ExitStatus {
	var code: Int32 {
		switch self {
			case let .signalled(code),
				let .terminated(code):
				return code
		}
	}
}
