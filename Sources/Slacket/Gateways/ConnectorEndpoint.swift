//
//  ConnectorEndpoint.swift
//  Slacket
//
//  Created by Jakub Tomanik on 04/06/16.
//
//

import Foundation
import Kitura
import SimpleHttpClient

protocol ConnectorEndpoint: URLType {
    
    var method: RouterMethod { get}
    var headers: [String: String]? { get }
    var acceptContentType: String? { get }
    var acceptHeaders: [String: String]? { get }
    var data: NSData? { get }
}

extension ConnectorEndpoint {
    
    var port: Int? {
        return 80
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var acceptHeaders: [String: String]? {
        return nil
    }
    
    var acceptContentType: String? {
        return nil
    }
    
    var data: NSData? {
        return nil
    }
    
    var resource: HttpResourse {
        return HttpResourse(schema: self.scheme.rawValue,
                            host: self.host,
                            port: "\(self.port)",
                            path: "/\(self.path)")
    }
    
    func request(completionHandler handler: NetworkRequestCompletionHandler) {
        ConnectorProvider.request(endpoint: self, completionHandler: handler)
    }
}
