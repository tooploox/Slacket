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

struct PocketAuthorizationRequestParser: ParserEncoderType {
    typealias Parsable = PocketAuthorizationRequestType
    
    static func parse(model: Parsable) -> ParsedBody? {
        guard let json = PocketAuthorizationRequestParser.encode(model: model) else {
            return nil
        }
        
        return ParsedBody.Json(json)
    }
    
    static func encode(model: Parsable) -> JSON? {
        var dictionary = [String: String]()
        dictionary["consumer_key"] = model.pocketConsumerKey
        dictionary["redirect_uri"] = model.pocketRedirectUri
        return JSON(dictionary)
    }
}
