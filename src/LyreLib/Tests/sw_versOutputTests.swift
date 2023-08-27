@testable import LyreLib
import XCTest

class sw_versOutputTests: XCTestCase {
	func testHelpFlag() throws {
		// Given
		let command = sw_versCommand(flag: .help)
		let mockOutput = """
		Usage: sw_vers [--help|--productName|--productVersion|--productVersionExtra|--buildVersion]
		"""
		let expectedHelpText = "Usage: sw_vers [--help|--productName|--productVersion|--productVersionExtra|--buildVersion]"
		let expectedOutput = sw_versOutput(helpText: expectedHelpText)

		// When
		let actualOutput = try XCTUnwrap(sw_versOutput.parse(
			output: mockOutput,
			for: command
		))

		// Then
		XCTAssertEqual(actualOutput, expectedOutput)
	}

	func testProductNameFlag() throws {
		// Given
		let command = sw_versCommand(flag: .productName)
		let mockOutput = """
		macOS
		"""
		let expectedProductName = "macOS"
		let expectedOutput = sw_versOutput(productName: expectedProductName)

		// When
		let actualOutput = try XCTUnwrap(sw_versOutput.parse(
			output: mockOutput,
			for: command
		))

		// Then
		XCTAssertEqual(actualOutput, expectedOutput)
	}

	func testProductVersionFlag() throws {
		// Given
		let command = sw_versCommand(flag: .productVersion)
		let mockOutput = """
		13.5.1
		"""
		let expectedProductVersion = "13.5.1"
		let expectedOutput = sw_versOutput(productVersion: expectedProductVersion)

		// When
		let actualOutput = try XCTUnwrap(sw_versOutput.parse(
			output: mockOutput,
			for: command
		))

		// Then
		XCTAssertEqual(actualOutput, expectedOutput)
	}

	func testProductVersionExtraFlag() throws {
		// Given
		let command = sw_versCommand(flag: .productVersionExtra)
		let mockOutput = """
		(a)
		"""
		let expectedProductVersionExtra = "(a)"
		let expectedOutput = sw_versOutput(productVersionExtra: expectedProductVersionExtra)

		// When
		let actualOutput = try XCTUnwrap(sw_versOutput.parse(
			output: mockOutput,
			for: command
		))

		// Then
		XCTAssertEqual(actualOutput, expectedOutput)
	}

	func testBuildVersionFlag() throws {
		// Given
		let command = sw_versCommand(flag: .buildVersion)
		let mockOutput = """
		22G90
		"""
		let expectedBuildVersion = "22G90"
		let expectedOutput = sw_versOutput(buildVersion: expectedBuildVersion)

		// When
		let actualOutput = try XCTUnwrap(sw_versOutput.parse(
			output: mockOutput,
			for: command
		))

		// Then
		XCTAssertEqual(actualOutput, expectedOutput)
	}

	func testNoFlags() throws {
		// Given
		let command = sw_versCommand()
		let mockOutput = """
		ProductName:			macOS
		ProductVersion:			13.5.1
		ProductVersionExtra:	(a)
		BuildVersion:			22G90
		"""
		let expectedOutput = sw_versOutput(
			productName: "macOS",
			productVersion: "13.5.1",
			productVersionExtra: "(a)",
			buildVersion: "22G90"
		)

		// When
		let actualOutput = try XCTUnwrap(sw_versOutput.parse(
			output: mockOutput,
			for: command
		))

		// Then
		XCTAssertEqual(actualOutput, expectedOutput)
	}
}
