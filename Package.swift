import PackageDescription

let package = Package(
    name: "Slacket",
    targets: [
                 Target(
                    name: "Slacket",
                    dependencies: [])
    ],
    dependencies: [
                      .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 0, minor: 17),
                      .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 0, minor: 9),
                      .Package(url: "https://github.com/swift-api/simple-http-client-swift", majorVersion: 0, minor: 2)
    ],
    exclude: ["Makefile", "Kitura-Build"]
)
