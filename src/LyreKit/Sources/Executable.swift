import Foundation

// MARK: - Executable

public protocol Executable {
	static var defaultLocation: URL { get }
}

// MARK: - ExecutableCommand

public protocol ExecutableCommand {
	var executableURL: URL { get }
	var arguments: [String] { get }
}

// MARK: - ExecutableOutput

public protocol ExecutableOutput: Equatable, Encodable {
	static func parse(output: Data, for command: ExecutableCommand) -> Self?
	static func parse(output: String, for command: ExecutableCommand) -> Self?
}
