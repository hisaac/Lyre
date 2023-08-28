@testable import LyreLib
import XCTest

class sw_versTests: XCTestCase {
	func testFlags() throws {
		// Given
		let noFlag = sw_vers.Command()
		let helpFlag = sw_vers.Command(flag: .help)
		let productNameFlag = sw_vers.Command(flag: .productName)
		let productVersionFlag = sw_vers.Command(flag: .productVersion)
		let productVersionExtraFlag = sw_vers.Command(flag: .productVersionExtra)
		let buildVersionFlag = sw_vers.Command(flag: .buildVersion)

		// Then
		XCTAssertEqual(noFlag.arguments, [])
		XCTAssertEqual(helpFlag.arguments, ["--help"])
		XCTAssertEqual(productNameFlag.arguments, ["--productName"])
		XCTAssertEqual(productVersionFlag.arguments, ["--productVersion"])
		XCTAssertEqual(productVersionExtraFlag.arguments, ["--productVersionExtra"])
		XCTAssertEqual(buildVersionFlag.arguments, ["--buildVersion"])
	}

	func testHelpFlag() throws {
		// Given
		let command = sw_vers.Command(flag: .help)
		let mockOutput = """
		Usage: sw_vers [--help|--productName|--productVersion|--productVersionExtra|--buildVersion]
		"""
		let expectedHelpText = "Usage: sw_vers [--help|--productName|--productVersion|--productVersionExtra|--buildVersion]"
		let expectedOutput = sw_vers.Output(helpText: expectedHelpText)

		// When
		let actualOutput = try XCTUnwrap(sw_vers.Output.parse(
			output: mockOutput,
			for: command
		))

		// Then
		XCTAssertEqual(actualOutput, expectedOutput)
	}

	func testProductNameFlag() throws {
		// Given
		let command = sw_vers.Command(flag: .productName)
		let mockOutput = """
		macOS
		"""
		let expectedProductName = "macOS"
		let expectedOutput = sw_vers.Output(productName: expectedProductName)

		// When
		let actualOutput = try XCTUnwrap(sw_vers.Output.parse(
			output: mockOutput,
			for: command
		))

		// Then
		XCTAssertEqual(actualOutput, expectedOutput)
	}

	func testProductVersionFlag() throws {
		// Given
		let command = sw_vers.Command(flag: .productVersion)
		let mockOutput = """
		13.5.1
		"""
		let expectedProductVersion = "13.5.1"
		let expectedOutput = sw_vers.Output(productVersion: expectedProductVersion)

		// When
		let actualOutput = try XCTUnwrap(sw_vers.Output.parse(
			output: mockOutput,
			for: command
		))

		// Then
		XCTAssertEqual(actualOutput, expectedOutput)
	}

	func testProductVersionExtraFlag() throws {
		// Given
		let command = sw_vers.Command(flag: .productVersionExtra)
		let mockOutput = """
		(a)
		"""
		let expectedProductVersionExtra = "(a)"
		let expectedOutput = sw_vers.Output(productVersionExtra: expectedProductVersionExtra)

		// When
		let actualOutput = try XCTUnwrap(sw_vers.Output.parse(
			output: mockOutput,
			for: command
		))

		// Then
		XCTAssertEqual(actualOutput, expectedOutput)
	}

	func testBuildVersionFlag() throws {
		// Given
		let command = sw_vers.Command(flag: .buildVersion)
		let mockOutput = """
		22G90
		"""
		let expectedBuildVersion = "22G90"
		let expectedOutput = sw_vers.Output(buildVersion: expectedBuildVersion)

		// When
		let actualOutput = try XCTUnwrap(sw_vers.Output.parse(
			output: mockOutput,
			for: command
		))

		// Then
		XCTAssertEqual(actualOutput, expectedOutput)
	}

	func testNoFlags() throws {
		// Given
		let command = sw_vers.Command()
		let mockOutput = """
		ProductName:			macOS
		ProductVersion:			13.5.1
		ProductVersionExtra:	(a)
		BuildVersion:			22G90
		"""
		let expectedOutput = sw_vers.Output(
			productName: "macOS",
			productVersion: "13.5.1",
			productVersionExtra: "(a)",
			buildVersion: "22G90"
		)

		// When
		let actualOutput = try XCTUnwrap(sw_vers.Output.parse(
			output: mockOutput,
			for: command
		))

		// Then
		XCTAssertEqual(actualOutput, expectedOutput)
	}
}
