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

enum URLSchema: String {
    case Http = "http"
    case Https = "https"
}

protocol URLType {
    
    /*
        This protocol abstracts URL,
        naming from RFC 1808, RFC 1738
        in order to provide better transition to NSURL in the future
        this is first revision and is still work in progress.
     */
    
    var scheme: URLSchema { get }
    var host: String { get }
    var port: Int? { get }
    var path: String { get }
    
    var baseURL: String { get }
    var absoluteString: String { get }
}

extension URLType {
    
    var port: Int? {
        return nil
    }
    
    var path: String {
        return ""
    }
    
    var baseURL: String {
        var port = ""
        if let portNum = self.port {
            port = ":\(portNum)"
        }
        return "\(self.scheme.rawValue)://\(self.host)\(port)/"
    }
    
    var absoluteString: String {
        return "\(self.baseURL)\(self.path)"
    }
}

protocol ServerConfig: URLType {}

extension ServerConfig {
    
    var scheme: URLSchema {
        #if os(OSX)
            return .Http
        #else
            return .Http
        #endif
    }
    
    var host: String {
        #if os(OSX)
            return "localhost"
        #else
            return "ec2-54-187-54-22.us-west-2.compute.amazonaws.com"
        #endif
    }
    
    var port: Int? {
        #if os(OSX)
            return 8090
        #else
            return nil
        #endif
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