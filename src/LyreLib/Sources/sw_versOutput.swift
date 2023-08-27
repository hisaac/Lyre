import Foundation

public struct sw_versOutput: Equatable, Encodable {
	public let helpText: String?
	public let productName: String?

	// TODO: Change this to `OperatingSystemVersion` type
	public let productVersion: String?
	public let productVersionExtra: String?
	public let buildVersion: String?

	internal init(
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
}

extension sw_versOutput {
	public static func parse(output: Data, for command: sw_versCommand) -> sw_versOutput? {
		guard let outputString = String(data: output, encoding: .utf8) else {
			return nil
		}
		return parse(output: outputString, for: command)
	}

	public static func parse(output: String, for command: sw_versCommand) -> sw_versOutput? {
		let outputLines = output
			.components(separatedBy: .newlines)
			.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
			.filter { $0.isEmpty == false }

		guard let firstOutputLine = outputLines.first else { return nil }

		switch command.flag {
			case .help:
				return sw_versOutput(helpText: firstOutputLine)
			case .productName:
				return sw_versOutput(productName: firstOutputLine)
			case .productVersion:
				return sw_versOutput(productVersion: firstOutputLine)
			case .productVersionExtra:
				return sw_versOutput(productVersionExtra: firstOutputLine)
			case .buildVersion:
				return sw_versOutput(buildVersion: firstOutputLine)
			case .none:
				let productName = parseValue(for: "ProductName:", from: outputLines)
				let productVersionExtra = parseValue(for: "ProductVersionExtra:", from: outputLines)
				let buildVersion = parseValue(for: "BuildVersion:", from: outputLines)
				let productVersion = parseValue(for: "ProductVersion:", from: outputLines)
				return sw_versOutput(
					productName: productName,
					productVersion: productVersion,
					productVersionExtra: productVersionExtra,
					buildVersion: buildVersion
				)
		}
	}

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
