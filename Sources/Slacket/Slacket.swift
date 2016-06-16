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



struct Slacket: ServerModuleType {
    
    let router: Router
    
    init(using router: Kitura.Router) {
        self.router = router
        self.setupRoutes()
    }
    
    mutating func setupRoutes() {
        router.all("*", middleware: StaticFileServer(path: "../../public", options: nil))
        router.all("api/*", middleware: BodyParser())
        router.all("api/*", middleware: SlacketHandler())
        
    }
}