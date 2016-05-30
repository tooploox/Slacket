//
//  SlackCommandRequestParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation
import Kitura

struct SlackCommandRequestParser: ParserDecoderType {
    typealias Parsable = SlackCommandRequestType
    
    static func parse(body: ParsedBody) -> Parsable? {
        switch body {
        case .UrlEncoded(let parameters):
            return SlackCommandRequestParser.decode(parameters: parameters)
        default:
            return nil
        }
    }
    
    static func decode(parameters: [String : String]) -> Parsable? {
        if let token = parameters["token"],
            let teamId = parameters["team_id"],
            let teamDomain = parameters["team_domain"],
            let channelId = parameters["channel_id"],
            let channelName = parameters["channel_name"],
            let userId = parameters["user_id"],
            let userName = parameters["user_name"],
            let command = parameters["command"],
            let responseUrl = parameters["response_url"],
            let text = parameters["text"] {
            return SlackCommandRequest(token: token,
                                teamId: teamId,
                                teamDomain: teamDomain,
                                channelId: channelId,
                                channelName: channelName,
                                userId: userId,
                                userName: userName,
                                command: command,
                                text: text,
                                responseUrl: responseUrl)
        } else {
            return nil
        }
    }
}