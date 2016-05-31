//
//  PocketAuthorizationResponseParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation
import Kitura
import SwiftyJSON

struct PocketAuthorizationResponseParser: ParserDecoderType {
    
    typealias Parsable = PocketAuthorizationResponseType
    typealias ParsedType = JsonType
    
    static func decode(raw: ParsedType) -> Parsable? {
        if let requestToken = raw["code"].string {
            return PocketAuthorizationResponse(pocketRequestToken: requestToken)
        } else {
            return nil
        }
    }
}