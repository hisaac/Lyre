import ArgumentParser
import Foundation

// @location: /usr/bin/sw_vers

public struct sw_versCommand: ParsableCommand {
	public init() {}

	@Flag(exclusivity: .chooseLast)
	var flag: sw_versFlag?

	enum sw_versFlag: String, EnumerableFlag {
		case help
		case productName
		case productVersion
		case productVersionExtra
		case buildVersion

		var name: String { "--\(rawValue)" }
	}
}

extension sw_versCommand {
	public var args: [String] {
		guard let flag else { return [] }
		return [flag.name]
	}
}
