import Foundation

import Kitura
import KituraNet
import KituraSys

import HeliumLogger
import LoggerAPI

import libc

protocol ServerModuleType {
    init(using router: Router)
    mutating func setupRoutes()
}

var workingDirectory: String {
    let parent = #file.characters.split(separator: "/").map(String.init).dropLast().joined(separator: "/")
    let path = "/\(parent)/"
    return path
}

var repoDirectory: String {
    let working = workingDirectory.characters.split(separator: "/").map(String.init).dropLast(2).joined(separator: "/")
    let path = "/\(working)/"
    return path
}

Log.logger = HeliumLogger()

let router = Router()
let slacket = Slacket(using: router)
Kitura.addHTTPServer(onPort: InternalServerConfig().port!, with: router)
Kitura.run()