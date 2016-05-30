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
    
    static func parse(model: Parsable) -> ParsedBody? {
        guard let json = PocketAccessTokenRequestParser.encode(model: model) else {
            return nil
        }
        
        return ParsedBody.Json(json)
    }
    
    static func encode(model: Parsable) -> JSON? {
        var dictionary = [String: String]()
        dictionary["consumer_key"] = model.pocketConsumerKey
        dictionary["code"] = model.pocketRequestToken
        return JSON(dictionary)
    }
}
