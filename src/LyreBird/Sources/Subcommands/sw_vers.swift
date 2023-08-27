import ArgumentParser
import Foundation
import LyreKit
import LyreLib

struct sw_vers: AsyncParsableCommand {

	@Flag(exclusivity: .chooseLast)
	var flag: sw_versCommand.sw_versFlag = .none

	func run() async throws {
		let output = try await LyreKit.sw_vers.run(command: sw_versCommand(flag: flag))
		guard let output else {
			print("No output")
			return
		}
		print(output)

		print("JSON")
		let outputJSON = try JSONEncoder().encode(output)
		guard let outputJSONString = String(data: outputJSON, encoding: .utf8) else { return }
		print(outputJSONString)

		print("PLIST")
		let propertyListEncoder = PropertyListEncoder()
		propertyListEncoder.outputFormat = .xml
		let outputPropertyList = try propertyListEncoder.encode(output)
		guard let outputPropertyListString = String(data: outputPropertyList, encoding: .utf8) else { return }
		print(outputPropertyListString)
	}
}

extension sw_versCommand.sw_versFlag: EnumerableFlag {}
