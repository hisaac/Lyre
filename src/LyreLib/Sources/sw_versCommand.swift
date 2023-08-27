import Foundation

public struct sw_versCommand {
	public let handlesStdIn = false
	public let executableURL: URL
	public let flag: sw_versFlag

	public init(
		executableURL: URL = URL(filePath: "/usr/bin/sw_vers"),
		flag: sw_versFlag = .none
	) {
		self.executableURL = executableURL
		self.flag = flag
	}

	public enum sw_versFlag: String, CaseIterable {
		case none = ""
		case help = "--help"
		case productName = "--productName"
		case productVersion = "--productVersion"
		case productVersionExtra = "--productVersionExtra"
		case buildVersion = "--buildVersion"
	}

	public var arguments: [String] {
		[flag.rawValue].filter { $0.isEmpty == false }
	}
}
