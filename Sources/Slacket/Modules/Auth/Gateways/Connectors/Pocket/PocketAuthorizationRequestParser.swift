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
    typealias ParsedType = JsonType
    
    static func encode(model: Parsable) -> ParsedType? {
        var dictionary = [String: String]()
        dictionary["consumer_key"] = model.pocketConsumerKey
        dictionary["redirect_uri"] = model.pocketRedirectUri
        #if os(Linux)
            return JSON(dictionary as Any)
        #else
            return JSON(dictionary as AnyObject)
        #endif
    }
}