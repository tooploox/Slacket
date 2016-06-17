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
    
    var router: Router { get }
    init(using router: Router)
    mutating func setupRoutes()
}

// Using an implementation for a Logger
Log.logger = HeliumLogger()

// All Web apps need a router to define routes
let router = Router()

let slacket = Slacket(using: router)

// Listen on port 80
#if os(OSX)
let serverPort = 8090
#else
let serverPort = 8090
#endif

let server = HTTPServer.listen(port: serverPort, delegate: router)
Kitura.run()