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
        router.all("api/*", middleware: BodyParser())
        router.all("api/*", middleware: SlacketHandler())
    }
}