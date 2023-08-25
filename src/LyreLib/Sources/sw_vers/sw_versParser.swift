import Foundation
import PackageDescription

public struct sw_versOutput {
	public let raw: String

	public let helpText: String?

	public let productName: String?
	public let productVersion: Version?
	public let productVersionExtra: String?
	public let buildVersion: String?

	init(
		raw: String,
		helpText: String? = nil,
		productName: String? = nil,
		productVersion: Version? = nil,
		productVersionExtra: String? = nil,
		buildVersion: String? = nil
	) {
		self.raw = raw
		self.helpText = helpText
		self.productName = productName
		self.productVersion = productVersion
		self.productVersionExtra = productVersionExtra
		self.buildVersion = buildVersion
	}
}

extension sw_versOutput {
	public static func parse(output: Data) throws -> sw_versOutput? {
		guard let outputString = String(data: output, encoding: .utf8) else {
			return nil
		}
		return try parse(output: outputString)
	}

	public static func parse(output: String) throws -> sw_versOutput? {
		return sw_versOutput(raw: output)
	}
}
