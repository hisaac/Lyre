@testable import LyreLib
import XCTest

class sw_versCommandTests: XCTestCase {
	func testFlags() throws {
		// Given
		let noFlag = sw_versCommand()
		let helpFlag = sw_versCommand(flag: .help)
		let productNameFlag = sw_versCommand(flag: .productName)
		let productVersionFlag = sw_versCommand(flag: .productVersion)
		let productVersionExtraFlag = sw_versCommand(flag: .productVersionExtra)
		let buildVersionFlag = sw_versCommand(flag: .buildVersion)

		// Then
		XCTAssertEqual(noFlag.arguments, [])
		XCTAssertEqual(helpFlag.arguments, ["--help"])
		XCTAssertEqual(productNameFlag.arguments, ["--productName"])
		XCTAssertEqual(productVersionFlag.arguments, ["--productVersion"])
		XCTAssertEqual(productVersionExtraFlag.arguments, ["--productVersionExtra"])
		XCTAssertEqual(buildVersionFlag.arguments, ["--buildVersion"])
	}
}
