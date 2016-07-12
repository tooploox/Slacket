//
//  SlackCommandParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation
import Kitura
import LoggerAPI

struct SlackCommandParser: ParserDecoderType {
    
    typealias Parsable = SlackCommandType
    typealias ParsedType = DictionaryType
    
    static func decode(raw: ParsedType) -> Parsable? {
        if let token = raw["token"],
            let teamId = raw["team_id"],
            let teamDomain = raw["team_domain"],
            let channelId = raw["channel_id"],
            let channelName = raw["channel_name"],
            let userId = raw["user_id"],
            let userName = raw["user_name"],
            let command = raw["command"],
            let responseUrl = raw["response_url"],
            let text = raw["text"] {
            return SlackCommand(token: token,
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
            Log.debug(AdapterError.slackCommandParserFailedDecoding(raw))
            return nil
        }
    }
}