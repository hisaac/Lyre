// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "Lyre",
	platforms: [.macOS(.v13)],
	products: [
		.library(name: "Lyre", targets: ["Lyre"]),
		.library(name: "LyreKit", targets: ["LyreKit"]),
		.executable(name: "lb", targets: ["LyreBird"]),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", exact: "1.2.3"),
		.package(url: "https://github.com/apple/swift-tools-support-core.git", exact: "0.5.2"),
	],
	targets: [
		// The lowest level library
		.target(
			name: "LyreKit",
			path: "src/LyreKit/Sources"
		),
		.testTarget(
			name: "LyreKitTests",
			dependencies: [
				.target(name: "LyreKit"),
			],
			path: "src/LyreKit/Tests"
		),

		// A high level library that lets you run commands
		.target(
			name: "Lyre",
			dependencies: [
				.target(name: "LyreKit"),
				.product(name: "TSCBasic", package: "swift-tools-support-core"),
			],
			path: "src/Lyre/Sources"
		),
		.testTarget(
			name: "LyreTests",
			dependencies: [
				.target(name: "Lyre"),
			],
			path: "src/Lyre/Tests"
		),

		// Mostly a demo and way of testing the libraries above
		.executableTarget(
			name: "LyreBird",
			dependencies: [
				.target(name: "Lyre"),
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			],
			path: "src/LyreBird/Sources"
		),
	]
)
