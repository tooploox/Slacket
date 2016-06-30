//
//  Slacket.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation
import Kitura
import HealthCheck

import libc

struct ExternalServerConfig: URLType {
    
    let host: String
    let port: Int?
    
    init() {
        if LaunchArgumentsProcessor.onLocalHost {
            self.host = "localhost"
            self.port = 8090
        } else {
            self.host = "slacket.link"
            self.port = nil
        }
    }
}

struct InternalServerConfig: URLType {

    let host: String = "localhost"
    let port: Int? = 8090
}

struct Slacket: ServerModuleType {

    private let router: Router

    init(using router: Router) {
        self.router = router
        self.setupRoutes()
    }

    mutating func setupRoutes() {
        let _ = router.get("/health-check", middleware: HealthCheck())
        let _ = router.get("/", middleware: StaticFileServer(path: repoDirectory+"public/"))
        router.all("api/*", middleware: BodyParser())
        router.all("api/*", middleware: SlacketHandler())
    }
}
