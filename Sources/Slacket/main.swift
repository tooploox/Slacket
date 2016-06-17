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

Log.logger = HeliumLogger()

let router = Router()
let slacket = Slacket(using: router)
Kitura.addHTTPServer(onPort: InternalServerConfig().port!, with: router)
Kitura.run()