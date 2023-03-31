// swift-tools-version: 5.7
import PackageDescription

let package = Package(
	name: "swift-prelude",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15)
	],
	products: [
		.library(
			name: "Prelude",
			targets: ["Prelude"]
		)
	],
	dependencies: [],
	targets: [
		.target(
			name: "Prelude",
			dependencies: []
		),
		.testTarget(
			name: "PreludeTests",
			dependencies: ["Prelude"]
		)
	]
)
