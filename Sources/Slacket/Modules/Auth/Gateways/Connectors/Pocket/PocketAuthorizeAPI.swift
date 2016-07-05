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
import LoggerAPI

enum PocketAuthorizeAPI: ConnectorEndpoint {
    
    case requestAuthorization(PocketAuthorizationRequestType)
    case requestAccessToken(PocketAccessTokenRequestType)
    
    var scheme: URLSchema {
        return .https
    }
    
    var host: String {
        return "getpocket.com"
    }
    
    var path: String {
        switch self {
        case .requestAuthorization:
            return "v3/oauth/request"
        case .requestAccessToken:
            return "v3/oauth/authorize"
            
        }
    }
    
    var headers: [String: String]? {
        let parserHeaders = self.parsedBody?.header ?? [:]
        let acceptHeaders = self.acceptHeaders ?? [:]
        return parserHeaders.merge(dict: acceptHeaders)
    }
    
    var acceptContentType: String? {
        return "application/x-www-form-urlencoded"
    }
    
    var acceptHeaders: [String: String]? {
        guard let contentType = self.acceptContentType else {
            Log.debug("contentType is nil")
            return nil
        }
        return ["X-Accept": "\(contentType); charset=UTF8"]
    }
    
    var method: RouterMethod {
        return .post
    }
    
    var data: NSData? {
        return self.parsedBody?.data
    }
    
    func redirectUrl(for response: PocketAuthorizationResponseType) -> String? {
        switch self {
        case .requestAuthorization(let req):
            if let redirectUrl = req.pocketRedirectUri.stringByAddingPercentEncoding() {
                return "https://getpocket.com/auth/authorize?request_token=\(response.pocketRequestToken)&redirect_uri=\(redirectUrl)"
            } else {
                Log.debug("redirectUrl is nil")
                return nil
            }
        case .requestAccessToken:
            return nil
            
        }
    }
    
    private var parsedBody: ParsedBody? {
        switch self {
        case .requestAuthorization(let req):
            return PocketAuthorizationRequestParser.parse(model: req)
        case .requestAccessToken(let req):
            return PocketAccessTokenRequestParser.parse(model: req)
        }
    }
}