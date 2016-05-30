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
    
    static func parse(body: ParsedBody) -> Parsable? {
        switch body {
        case .Json(let json):
            return PocketAddResponseParser.decode(json: json)
        default:
            return nil
        }
    }
    
    static func decode(json: JSON) -> Parsable? {
        let itemJson = json["item"]
        if let item = PocketItemParser.parse(body: ParsedBody.Json(itemJson)),
            let status = json["status"].int {
            return PocketAddResponse(item: item, status: status)
        } else {
            return nil
        }
    }
}
