// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "Lyre",
	platforms: [.macOS(.v13)],
	products: [
		.library(name: "LyreLib", targets: ["LyreLib"]),
		.library(name: "LyreKit", targets: ["LyreKit"]),
		.executable(name: "lb", targets: ["LyreBird"]),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", exact: "1.2.3"),
	],
	targets: [
		.target(
			name: "LyreLib",
			path: "src/LyreLib/Sources"
		),
		.testTarget(
			name: "LyreLibTests",
			dependencies: [
				.target(name: "LyreLib")
			],
			path: "src/LyreLib/Tests"
		),

		.target(
			name: "LyreKit",
			dependencies: [
				.target(name: "LyreLib")
			],
			path: "src/LyreKit/Sources"
		),
		.testTarget(
			name: "LyreKitTests",
			dependencies: [
				.target(name: "LyreKit")
			],
			path: "src/LyreKit/Tests"
		),

		.executableTarget(
			name: "LyreBird",
			dependencies: [
				.target(name: "LyreKit"),
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			],
			path: "src/LyreBird/Sources"
		)
	]
)
