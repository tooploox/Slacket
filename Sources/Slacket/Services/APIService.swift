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

protocol APIService {
    
    var schema: APIRequestSchema { get }
    var host: String { get }
}

extension APIService {
    
    var schema: APIRequestSchema {
        return .Https
    }
    var host: String {
        return "slacket.link"
    }
}

protocol BasicServiceType {
    
    var errorDomain: String { get }
}

extension BasicServiceType {
    
    func getError(message: String) -> NSError {
        return NSError(domain: self.errorDomain,
                                 code: 1,
                                 userInfo: [NSLocalizedDescriptionKey: message])
    }
}

protocol UserInfoServiceType: BasicServiceType, RouterMiddleware {
    
    static var userInfoKey: String { get }
}

protocol APIServiceType: BasicServiceType, RouterMiddleware {
    
    // This one will be used as a part of URL ./api/v1/:service_name/
    //var name: String { get }
    var endpoint: APIServiceEndpointType { get }
}