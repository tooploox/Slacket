//
//  PocketAuthorizationRequestParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation
import Kitura
import SwiftyJSON

struct PocketAccessTokenRequestParser: ParserEncoderType {
    
    typealias Parsable = PocketAccessTokenRequestType
    typealias ParsedType = JsonType
    
    static func encode(model: Parsable) -> ParsedType? {
        var dictionary = [String: String]()
        dictionary["consumer_key"] = model.pocketConsumerKey
        dictionary["code"] = model.pocketRequestToken
        return JSON(dictionary as! AnyObject)
    }
}