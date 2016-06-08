import Foundation

import Kitura
import KituraNet
import KituraSys

import HeliumLogger
import LoggerAPI

#if os(Linux)
    import Glibc
#endif

protocol ServerModuleType {
    
    var router: Kitura.Router { get }
    init(using router: Kitura.Router)
    mutating func setupRoutes()
}

// Using an implementation for a Logger
Log.logger = HeliumLogger()

// All Web apps need a router to define routes
let router = Kitura.Router()

let slacket = Slacket(using: router)

// Listen on port 80
#if os(OSX)
let serverPort = 8090
#else
let serverPort = 8090
#endif

let server = HttpServer.listen(port: serverPort, delegate: router)
Server.run()