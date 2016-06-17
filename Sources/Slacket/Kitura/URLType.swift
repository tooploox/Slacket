//
//  URLType.swift
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
    case http = "http"
    case https = "https"
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

    var scheme: URLSchema {
        return .http
    }

    var port: Int? {
        return nil
    }
    
    var path: String {
        return ""
    }
    
    var baseURL: String {
        var portString = ""
        if let portNum = self.port {
            portString = ":\(portNum)"
        }
        return "\(self.scheme.rawValue)://\(self.host)\(portString)/"
    }
    
    var absoluteString: String {
        return "\(self.baseURL)\(self.path)"
    }
}

protocol ErrorType {
    
    static var errorDomain: String { get }
}

extension ErrorType {
    
    func getError(message: String) -> NSError {
        return NSError(domain: Self.errorDomain,
                                 code: 1,
                                 userInfo: nil)
    }
}