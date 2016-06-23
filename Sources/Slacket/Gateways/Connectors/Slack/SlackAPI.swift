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
import Environment

protocol SlackAppType {
    
    var slackToken: String { get }
}

extension SlackAppType {
    
    var slackToken: String {
        return Environment().getVar("SLACK_TOKEN")
    }
}

enum SlackAPI: ConnectorEndpoint {
    
    case respond(command: SlackCommandType, message: SlackMessageType)
    
    var scheme: URLSchema {
        return .https
    }
    
    var host: String {
        return "hooks.slack.com"
    }
    
    var path: String {
        switch self {
        case .respond(let command, _):
            let responseUrl = command.responseUrl
            let path = responseUrl.replaceOccurrences(of: self.baseURL, with: "")
            return path
        }
    }
    
    var headers: [String: String]? {
        let parserHeaders = self.parsedBody?.header ?? [:]
        let acceptHeaders = self.acceptHeaders ?? [:]
        return parserHeaders.merge(dict: acceptHeaders)
    }
    
    var method: RouterMethod {
        return .post
    }
    
    var data: NSData? {
        return self.parsedBody?.data
    }
    
    private var parsedBody: ParsedBody? {
        switch self {
        case .respond(_, let message):
            return SlackMessageParser.parse(model: message)
        }
    }
}