import PackageDescription

let package = Package(
    name: "Slacket",
    targets: [
                 Target(
                    name: "Slacket",
                    dependencies: [])
    ],
    dependencies: [
                      .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 0, minor: 11),
                      .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 0, minor: 6),
                      .Package(url: "https://github.com/swift-api/simple-http-client-swift", majorVersion: 0, minor: 1)
    ],
    exclude: ["Makefile", "Kitura-Build"]
)