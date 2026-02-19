// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
	name: "AwesomeSwiftyComponents",
	defaultLocalization: "en",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
		.watchOS(.v6),
		.visionOS(.v1),
		.macCatalyst(.v13)
	],
	products: [
		// Products define the executables and libraries a package produces, making them visible to other packages.
		.library(
			name: "AwesomeSwiftyComponents",
			targets: ["AwesomeSwiftyComponents"]),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-syntax.git", from: "510.0.2"),
	],
	targets: [
		// Targets are the basic building blocks of a package, defining a module or a test suite.
		// Targets can depend on other targets in this package and products from dependencies.
		.target(
			name: "AwesomeSwiftyComponents",
			dependencies: ["AwesomeSwiftyComponentsMacros"]),
		.macro(
			name: "AwesomeSwiftyComponentsMacros",
			dependencies: [
				.product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
				.product(name: "SwiftSyntax", package: "swift-syntax"),
				.product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
				.product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
			])
	]
)
