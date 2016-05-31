//
//  PocketAPI.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation
import Kitura
import SimpleHttpClient

enum PocketAPI: APIClientEndpointType {
    
    case Add(PocketAddRequestType)
    case RequestAuthorization(PocketAuthorizationRequestType)
    case RequestAccessToken(PocketAccessTokenRequestType)
    
    var schema: APIRequestSchema {
        return .Https
    }
    
    var host: String {
        return "getpocket.com"
    }
    
    var path: String {
        switch self {
        case .Add:
            return "/v3/add"
        case .RequestAuthorization:
            return "/v3/oauth/request"
        case .RequestAccessToken:
            return "/v3/oauth/authorize"
            
        }
    }
    
    var port: Int {
        return 80
    }
    
    var headers: [String: String]? {
        let parserHeaders = self.parsedBody?.header ?? [:]
        let acceptHeaders = self.acceptHeaders ?? [:]
        return parserHeaders.merge(dict: acceptHeaders)
    }
    
    var acceptContentType: String? {
        return "application/json"
    }
    
    var acceptHeaders: [String: String]? {
        guard let contentType = self.acceptContentType else {
            return nil
        }
        return ["X-Accept": "\(contentType); charset=UTF8"]
    }
    
    var method: RouterMethod {
        return .Post
    }
    
    var data: NSData? {
        return self.parsedBody?.data
    }
    
    private var parsedBody: ParsedBody? {
        switch self {
        case .Add(let req):
            return PocketAddRequestParser.parse(model: req)
        case .RequestAuthorization(let req):
            return PocketAuthorizationRequestParser.parse(model: req)
        case .RequestAccessToken(let req):
            return PocketAccessTokenRequestParser.parse(model: req)
        }
    }
}

private extension Dictionary {
    func merge(dict: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
        var mutableCopy = self
        for (key, value) in dict {
            // If both dictionaries have a value for same key, the value of the other dictionary is used.
            mutableCopy[key] = value
        }
        return mutableCopy
    }
}