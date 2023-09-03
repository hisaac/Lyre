import ArgumentParser
import Foundation
import LyreKit
import Lyre

// MARK: - sw_vers

struct sw_vers: AsyncParsableCommand {
	@Flag(exclusivity: .chooseLast)
	var flag: LyreKit.sw_vers.Command.sw_versFlag = .none

	func run() async throws {
		let output = try await Lyre.sw_vers.run(command: LyreKit.sw_vers.Command(flag: flag))
		guard let output else {
			print("No output")
			return
		}
		print(output)

		print("JSON")
		let outputJSON = try JSONEncoder().encode(output)
		guard let outputJSONString = String(data: outputJSON, encoding: .utf8) else {
			return
		}
		print(outputJSONString)

		print("PLIST")
		let propertyListEncoder = PropertyListEncoder()
		propertyListEncoder.outputFormat = .xml
		let outputPropertyList = try propertyListEncoder.encode(output)
		guard let outputPropertyListString = String(data: outputPropertyList, encoding: .utf8) else {
			return
		}
		print(outputPropertyListString)
	}
}

// MARK: - LyreKit.sw_vers.Command.sw_versFlag + EnumerableFlag

extension LyreKit.sw_vers.Command.sw_versFlag: EnumerableFlag {}
