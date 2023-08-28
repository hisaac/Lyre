@testable import LyreKit
@testable import LyreLib
import XCTest

class sw_versTests: XCTestCase {
	func testRun() async throws {
		// Given
		let command = sw_vers.Command()
		let expectedOutput = sw_vers.Output(
			productName: "macOS",
			productVersion: "13.5.1",
			buildVersion: "22G90"
		)

		// When
		let output = try await sw_vers.run(command: command)

		// Then
		XCTAssertEqual(output, expectedOutput)
	}
}
