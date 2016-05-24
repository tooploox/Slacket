import Foundation

import Kitura
import KituraNet
import KituraSys

import HeliumLogger
import LoggerAPI

#if os(Linux)
    import Glibc
#endif

// Using an implementation for a Logger
Log.logger = HeliumLogger()

// All Web apps need a router to define routes
let router = Kitura.Router()

router.get("/") { request, response, next in
    Log.debug("Hello, World!")
    response.status(.OK).send("Hello, World!")
    next()
}

// Listen on port 80
#if os(OSX)
let serverPort = 8090
#else
let serverPort = 80
#endif

let server = HttpServer.listen(port: serverPort, delegate: router)
Server.run()