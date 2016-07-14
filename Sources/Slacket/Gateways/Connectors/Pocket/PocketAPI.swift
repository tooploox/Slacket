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
import Environment
import LoggerAPI

protocol PocketAppType {
    
    var pocketConsumerKey: String { get }
}

extension PocketAppType {
    
    var pocketConsumerKey: String {
        guard let key = Environment().getVar("POCKET_CONSUMER_KEY") else {
            Log.error(SlacketError.pocketMissingConsumerKey)
            fatalError()
        }
        return key
    }
}

enum PocketAPI: ConnectorEndpoint {
    
    case add(PocketAddRequestType)
    
    var scheme: URLSchema {
        return .https
    }
    
    var host: String {
        return "getpocket.com"
    }
    
    var path: String {
        switch self {
        case .add:
            return "v3/add"
        }
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
        return .post
    }
    
    var data: NSData? {
        return self.parsedBody?.data
    }
    
    private var parsedBody: ParsedBody? {
        switch self {
        case .add(let req):
            return PocketAddRequestParser.parse(model: req)
        }
    }
}