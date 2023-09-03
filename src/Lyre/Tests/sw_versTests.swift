@testable import Lyre
@testable import LyreKit
import XCTest

class sw_versTests: XCTestCase {
	func testRun() async throws {
		// Given
		let command = LyreKit.sw_vers.Command()
		let expectedOutput = LyreKit.sw_vers.Output(
			productName: "macOS",
			productVersion: "13.5.1",
			buildVersion: "22G90"
		)

		// When
		let output = try await Lyre.sw_vers.run(command: command)

		// Then
		XCTAssertEqual(output, expectedOutput)
	}
}
