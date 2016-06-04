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

extension PocketAddRequestType {
    
    var decodedURL: String {        
        guard let url = url.withoutPercentEncoding() else {
            fatalError("URL decodaing failed")
        }
        return url
    }
    
    var tagsString: String {
        let tags = self.tags?.joinedBy(separator: ",")
        return tags ?? ""
    }
}

struct PocketAddRequestParser: ParserEncoderType {
    
    typealias Parsable = PocketAddRequestType
    typealias ParsedType = JsonType
    
    static func encode(model: Parsable) -> ParsedType? {
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