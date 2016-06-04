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

enum PocketAuthorizeAPI: ConnectorEndpoint {
    
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
    
    func redirectUrl(for response: PocketAuthorizationResponseType) -> String? {
        switch self {
        case .RequestAuthorization(let req):
            return "\(self.schema.rawValue)://\(self.host)/\(self.path)?request_token=\(response.pocketRequestToken)&redirect_uri=\(req.pocketRedirectUri)"
        case .RequestAccessToken:
            return nil
            
        }
    }
    
    private var parsedBody: ParsedBody? {
        switch self {
        case .RequestAuthorization(let req):
            return PocketAuthorizationRequestParser.parse(model: req)
        case .RequestAccessToken(let req):
            return PocketAccessTokenRequestParser.parse(model: req)
        }
    }
}