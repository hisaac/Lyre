@testable import LyreKit
@testable import LyreLib

import XCTest

class sw_versTests: XCTestCase {
	func testRun() async throws {
		// Given
		let command = sw_versCommand()
		let expectedOutput = sw_versOutput(
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
