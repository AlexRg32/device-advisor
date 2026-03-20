// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "DeviceAdvisor",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .executable(
            name: "DeviceAdvisor",
            targets: ["DeviceAdvisor"]
        ),
    ],
    targets: [
        .executableTarget(
            name: "DeviceAdvisor",
            path: "Sources/DeviceAdvisor"
        ),
        .testTarget(
            name: "DeviceAdvisorTests",
            dependencies: ["DeviceAdvisor"]
        ),
    ]
)
