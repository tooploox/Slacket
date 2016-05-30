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
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            let decodedUrl = url.stringByRemovingPercentEncoding
        #else
            let decodedUrl = url.removingPercentEncoding
        #endif
        
        guard let url = decodedUrl else {
            fatalError("URL decodaing failed")
        }
        return url
    }
    
    var tagsString: String {
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            let tags = self.tags?.componentsJoinedByString(",")
        #else
            let tags = self.tags?.joined(separator: ",")
        #endif
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