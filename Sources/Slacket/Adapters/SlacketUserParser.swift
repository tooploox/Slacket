//
//  SlacketUserParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation
import LoggerAPI

struct SlacketUserParser: ParserDecoderType {
    
    typealias Parsable = SlacketUserType
    typealias ParsedType = DictionaryType
    
    static func decode(raw: ParsedType) -> Parsable? {
        Log.debug(raw.description)
        if let slackId = raw["user"],
            let teamId = raw["team"] {
            return SlacketUser(slackId: slackId,
                               slackTeamId: teamId,
                               pocketAccessToken: raw["pocket_access_token"],
                               pocketUsername: raw["pocket_user"])
        } else {
            Log.debug("Failed to decode SlacketUser \(raw)")
            return nil
        }
    }
}

extension SlacketUserParser: ParserEncoderType {

    static func encode(model: Parsable) -> ParsedType? {
        var raw = [String: String]()
        raw["user"] = model.slackId
        raw["team"] = model.slackTeamId
        if let pocketAccessToken = model.pocketAccessToken {
            raw["pocket_access_token"] = pocketAccessToken
        }
        if let pocketUsername = model.pocketUsername {
            raw["pocket_user"] = pocketUsername
        }
        Log.debug(raw.description)
        return raw
    }
}