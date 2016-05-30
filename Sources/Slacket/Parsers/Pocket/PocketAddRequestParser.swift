//
//  PocketAddRequestParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation
import Kitura
import SwiftyJSON

struct PocketAddRequestParser: ParserEncoderType {
    typealias Parsable = PocketAddRequestType
    
    static func parse(model: Parsable) -> ParsedBody? {
        guard let json = PocketAddRequestParser.encode(model: model) else {
            return nil
        }
        
        return ParsedBody.Json(json)
    }
    
    static func encode(model: Parsable) -> JSON? {
        var dictionary = [String: String]()
        dictionary["consumer_key"] = model.pocketConsumerKey
        dictionary["access_token"] = model.pocketAccessToken
        dictionary["url"] = model.decodedURL
        if let _ = model.tags {
            dictionary["tags"] = model.tagsString
        }
        if let tweetId = model.tweetId {
            dictionary["access_token"] = tweetId
        }
        
        return JSON(dictionary)
    }
}