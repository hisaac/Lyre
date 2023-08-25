@testable import LyreLib
import PackageDescription
import XCTest

class sw_versTests: XCTestCase {
	func testHelpFlag() throws {
		// Given
		let mockOutput = """
		Usage: sw_vers [--help|--productName|--productVersion|--productVersionExtra|--buildVersion]
		"""
		let expectedHelpText = "Usage: sw_vers [--help|--productName|--productVersion|--productVersionExtra|--buildVersion]"

		// When
		// Then
	}

	func testProductNameFlag() throws {
		// Given
		let mockOutput = """
		macOS
		"""
		let expectedProductName = "macOS"

		// When
		// Then
	}

	func testProductVersionFlag() throws {
		// Given
		let mockOutput = """
		13.5.1
		"""
		let expectedProductVersion = Version(13, 5, 1)

		// When
		// Then
	}

	func testProductVersionExtraFlag() throws {
		// Given
		let mockOutput = """
		(a)
		"""
		let expectedProductVersionExtra = "(a)"

		// When
		// Then
	}

	func testBuildVersionFlag() throws {
		// Given
		let mockOutput = """
		22G90
		"""
		let expectedBuildVersion = "22G90"

		// When
		// Then
	}

	func testNoFlags() throws {
		// Given
		let mockOutput = """
		ProductName:			macOS
		ProductVersion:			13.5.1
		ProductVersionExtra:	(a)
		BuildVersion:			22G90
		"""
//		let expectedResult = sw_vers.Result(
//			productName: "macOS",
//			productVersion: Version(13, 5, 1),
//			productVersionExtra: "(a)",
//			buildVersion: "22G90"
//		)

		// When
		// Then
	}

	func testProductVersionFull() throws {
		// Given
//		let mockResult = sw_vers.Result(
//			productVersion: Version(13, 5, 1),
//			productVersionExtra: "(a)",
//			buildVersion: "22G90"
//		)
//		let expectedProductVersionFull = Version(
//			13, 5, 1,
//			prereleaseIdentifiers: ["(a)"],
//			buildMetadataIdentifiers: ["22G90"]
//		)

		// When
		// Then
	}
}
