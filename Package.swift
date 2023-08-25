// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "Lyre",
	platforms: [.macOS(.v13)],
	products: [
		.library(name: "LyreKit", targets: ["LyreKit"]),
		.library(name: "LyreLib", targets: ["LyreLib"]),
		.executable(name: "lb", targets: ["LyreBird"]),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", exact: "1.2.3"),
		.package(url: "https://github.com/apple/swift-package-manager.git", exact: "0.6.0"),
		.package(url: "https://github.com/tannerdsilva/SwiftSlash.git", revision: "10a6080470d0fe481ca2b5ad6acdfc8246cf5406"),
	],
	targets: [
		// A CLI tool that can be used to test
		.executableTarget(
			name: "LyreBird",
			dependencies: [
				.target(name: "LyreKit"),
			],
			path: "src/LyreBird/Sources"
		),

		// Can be used wholesale to run commands and handle their output
		.target(
			name: "LyreKit",
			dependencies: [
				.product(name: "SwiftSlash", package: "SwiftSlash"),
				.target(name: "LyreLib"),
			],
			path: "src/LyreKit/Sources"
		),

		// Swift representations of executable commands and command output parsers
		.target(
			name: "LyreLib",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "PackageDescription", package: "swift-package-manager"),
			],
			path: "src/LyreLib/Sources"
		),
		.testTarget(
			name: "LyreLibTests",
			dependencies: [.target(name: "LyreLib")],
			path: "src/LyreLib/Tests"
		)
	]
)
