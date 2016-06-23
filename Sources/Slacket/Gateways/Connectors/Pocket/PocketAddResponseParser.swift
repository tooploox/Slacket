//
//  PocketAddResponseParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation
import Kitura
import SwiftyJSON

struct PocketAddResponseParser: ParserDecoderType {
    
    typealias Parsable = PocketAddResponseType
    typealias ParsedType = JsonType
    
    static func decode(raw: ParsedType) -> Parsable? {
        let itemJson = raw["item"]
        if let item = PocketItemParser.parse(body: ParsedBody.json(itemJson)),
            let status = raw["status"].int {
            return PocketAddResponse(item: item, status: status)
        } else {
            return nil
        }
    }
}