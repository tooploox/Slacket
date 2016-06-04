//
//  SlacketUserParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation

struct SlacketUserParser: ParserDecoderType {
    
    typealias Parsable = SlacketUserType
    typealias ParsedType = DictionaryType
    
    static func decode(raw: ParsedType) -> Parsable? {
        if let slackId = raw["user"],
            let teamId = raw["team"] {
            return SlacketUser(slackId: slackId,
                               slackTeamId: teamId,
                               pocketAccessToken: nil,
                               pocketUsername: nil)
        } else {
            return nil
        }
    }
}