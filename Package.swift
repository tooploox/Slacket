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
        .Package(url: "https://github.com/jtomanik/Environment.git", majorVersion: 0, minor: 3),
        .Package(url: "https://github.com/tooploox/Kitura-HealthCheck.git", majorVersion: 0, minor: 2),
        .Package(url: "https://github.com/Zewo/Mustache.git", majorVersion: 0, minor: 6),
        .Package(url: "https://github.com/czechboy0/Redbird.git", majorVersion: 0, minor: 7)
    ],
    exclude: ["Makefile", "Kitura-Build"]
)