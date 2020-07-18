// swift-tools-version:5.1
//
//  Package.swift
//  Base32
//

import PackageDescription

let package = Package(
	name: "Base32",
	products: [
		.library(
			name: "Base32",
			targets: ["Base32"]),
	],
	dependencies: [
		.package(url: "https://github.com/std-swift/Encoding.git",
		         from: "2.0.0"),
	],
	targets: [
		.target(
			name: "Base32",
			dependencies: [
				.product(name: "Encoding", package: "Encoding"),
			]),
		.testTarget(
			name: "Base32Tests",
			dependencies: ["Base32"]),
	]
)
