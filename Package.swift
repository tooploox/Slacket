import PackageDescription

let package = Package(
    name: "Slacket",
    targets: [
                 Target(
                    name: "Slacket",
                    dependencies: [])
    ],
    dependencies: [
                      .Package(url: "https://github.com/qutheory/libc.git", majorVersion: 0, minor: 1),
                      .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 0, minor: 19),
                      .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 0, minor: 9),
                      .Package(url: "https://github.com/swift-api/simple-http-client-swift.git", majorVersion: 0, minor: 2),
                      .Package(url: "https://github.com/jtomanik/Environment.git", majorVersion: 0, minor: 3)
    ],
    exclude: ["Makefile", "Kitura-Build"]
)
