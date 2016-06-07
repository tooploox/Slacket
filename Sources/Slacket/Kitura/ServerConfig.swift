//
//  APIService.swift
//  Slacket
//
//  Created by Jakub Tomanik on 20/05/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

protocol ServerConfig {
    
    var schema: APIRequestSchema { get }
    var host: String { get }
}

extension ServerConfig {
    
    var schema: APIRequestSchema {
        return .Https
    }
    
    var host: String {
        return "localhost"
    }
}

protocol ErrorType {
    
    static var errorDomain: String { get }
}

extension ErrorType {
    
    func getError(message: String) -> NSError {
        return NSError(domain: Self.errorDomain,
                                 code: 1,
                                 userInfo: [NSLocalizedDescriptionKey: message])
    }
}