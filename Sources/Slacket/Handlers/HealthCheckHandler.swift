//
//  HealthCheckHandler.swift
//  Slacket
//
//  Created by Jeremi Kaczmarczyk on 22.06.2016.
//
//

import Foundation

import Kitura
import HeliumLogger
import LoggerAPI

class HealthCheckHandler: Handler, RouterMiddleware {

    func handle(request: RouterRequest, response: RouterResponse, next: () -> Void) throws {
        try response.end()
        Log.info("Health check performed. Status: OK.")
    }
}