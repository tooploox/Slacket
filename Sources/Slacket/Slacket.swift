//
//  Slacket.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

#if os(Linux)
    import Glibc
#endif

struct ExternalServerConfig: URLType {

    let host: String = "slacket.link"
}

struct InternalServerConfig: URLType {

    let host: String = "localhost"
    let port: Int? = 8090
}

struct Slacket: ServerModuleType {

    let router: Router

    init(using router: Router) {
        self.router = router
        self.setupRoutes()
    }

    mutating func setupRoutes() {
        //router.get("/", middleware: StaticFileServer(path: "/Users/jakubtomanik/Documents/SwiftAPI/Slacket_prv/public/"))
        router.get("/", middleware: StaticFileServer(path: calculatePath()))
        router.all("api/*", middleware: BodyParser())
        router.all("api/*", middleware: SlacketHandler())
    }

    private func calculatePath() -> String {
        let currentPath = #file
        let baseDir = currentPath.replaceOccurrences(of: "Sources/Slacket/Slacket.swift", with: "")
        let publicDir = baseDir+"public/"
        return publicDir
    }
}