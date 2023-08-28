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

// MARK: - sw_vers

public struct sw_vers: Executable {
	public struct Command: ExecutableCommand {
		// MARK: Lifecycle

		public init(
			executableURL: URL = sw_vers.defaultLocation,
			flag: sw_versFlag = .none
		) {
			self.executableURL = executableURL
			self.flag = flag
		}

		// MARK: Public

		public enum sw_versFlag: String, CaseIterable {
			case none = ""
			case help = "--help"
			case productName = "--productName"
			case productVersion = "--productVersion"
			case productVersionExtra = "--productVersionExtra"
			case buildVersion = "--buildVersion"
		}

		public let handlesStdIn = false
		public var executableURL: URL
		public let flag: sw_versFlag

		public var arguments: [String] {
			[flag.rawValue].filter { $0.isEmpty == false }
		}
	}

	public struct Output: ExecutableOutput {
		// MARK: Lifecycle

		init(
			helpText: String? = nil,
			productName: String? = nil,
			productVersion: String? = nil,
			productVersionExtra: String? = nil,
			buildVersion: String? = nil
		) {
			self.helpText = helpText
			self.productName = productName
			self.productVersion = productVersion
			self.productVersionExtra = productVersionExtra
			self.buildVersion = buildVersion
		}

		// MARK: Public

		public let helpText: String?
		public let productName: String?

		// TODO: Change this to `OperatingSystemVersion` type
		public let productVersion: String?
		public let productVersionExtra: String?
		public let buildVersion: String?

		public static func parse(output: Data, for command: ExecutableCommand) -> sw_vers.Output? {
			guard let outputString = String(data: output, encoding: .utf8) else {
				return nil
			}
			return parse(output: outputString, for: command)
		}

		public static func parse(output: String, for command: ExecutableCommand) -> sw_vers.Output? {
			let outputLines = output
				.components(separatedBy: .newlines)
				.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
				.filter { $0.isEmpty == false }

			guard let firstOutputLine = outputLines.first else {
				return nil
			}

			if let firstArgument = command.arguments.first {
				let argument = sw_vers.Command.sw_versFlag(rawValue: firstArgument)
				switch argument {
				case .help:
					return sw_vers.Output(helpText: firstOutputLine)
				case .productName:
					return sw_vers.Output(productName: firstOutputLine)
				case .productVersion:
					return sw_vers.Output(productVersion: firstOutputLine)
				case .productVersionExtra:
					return sw_vers.Output(productVersionExtra: firstOutputLine)
				case .buildVersion:
					return sw_vers.Output(buildVersion: firstOutputLine)
				default:
					return nil
				}
			} else {
				let productName = parseValue(for: "ProductName:", from: outputLines)
				let productVersionExtra = parseValue(for: "ProductVersionExtra:", from: outputLines)
				let buildVersion = parseValue(for: "BuildVersion:", from: outputLines)
				let productVersion = parseValue(for: "ProductVersion:", from: outputLines)
				return sw_vers.Output(
					productName: productName,
					productVersion: productVersion,
					productVersionExtra: productVersionExtra,
					buildVersion: buildVersion
				)
			}
		}

		// MARK: Private

		private static func parseValue(for flag: String, from sourceLines: [String]) -> String? {
			for line in sourceLines {
				if line.starts(with: flag) {
					let splitLine = line.split(separator: flag)
					return splitLine.first?.trimmingCharacters(in: .whitespacesAndNewlines)
				}
			}
			return nil
		}
	}

	public static let defaultLocation = URL(filePath: "/usr/bin/sw_vers")
}
