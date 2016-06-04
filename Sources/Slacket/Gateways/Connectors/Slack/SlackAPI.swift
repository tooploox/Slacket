//
//  PocketAPI.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation
import Kitura
import KituraNet
import SimpleHttpClient

protocol SlackAppType {
    
    var slackToken: String { get }
}

extension SlackAppType {
    
    var slackToken: String {
        return "SJ0sPVUmpujXy52BIK8NV7nn"
    }
}

enum SlackAPI: ConnectorEndpoint {
    
    case Respond(command: SlackCommandType, message: SlackMessageType)
    
    var schema: APIRequestSchema {
        return .Https
    }
    
    var host: String {
        return "hooks.slack.com"
    }
    
    var path: String {
        switch self {
        case .Respond(let command, _):
            let responseUrl = command.responseUrl
            let path = responseUrl.replacingOccurrences(of: "\(self.schema.rawValue)://\(self.host)/", with: "")
            return path
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
    
    var method: RouterMethod {
        return .Post
    }
    
    var data: NSData? {
        return self.parsedBody?.data
    }
    
    private var parsedBody: ParsedBody? {
        switch self {
        case .Respond(_, let message):
            return SlackMessageParser.parse(model: message)
        }
    }
}