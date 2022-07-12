// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "PrintAccessoryHosting",
	platforms: [.macOS(.v10_15)],
	products: [
		.library(
			name: "PrintAccessoryHosting",
			targets: ["PrintAccessoryHosting"]
		),
	],
	dependencies: [
		
	],
	targets: [
		.target(
			name: "PrintAccessoryHosting",
			dependencies: []
		),
		.testTarget(
			name: "PrintAccessoryHostingTests",
			dependencies: ["PrintAccessoryHosting"]
		),
	]
)
