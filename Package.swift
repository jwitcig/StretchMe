// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Textend",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "TextendCore", targets: ["TextendCore"]),
        .library(name: "TextendUI", targets: ["TextendUI"]),
        .executable(name: "textend-cli", targets: ["TextendCLI"])
    ],
    targets: [
        .target(
            name: "TextendCore",
            path: "Sources/TextendCore"
        ),
        .target(
            name: "TextendUI",
            dependencies: ["TextendCore"],
            path: "Sources/TextendUI"
        ),
        .executableTarget(
            name: "TextendCLI",
            dependencies: ["TextendCore", "TextendUI"],
            path: "Sources/TextendCLI"
        ),
        .testTarget(
            name: "TextendCoreTests",
            dependencies: ["TextendCore"],
            path: "Tests/TextendCoreTests"
        )
    ]
)
