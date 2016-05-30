//
//  PocketItemParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation
import Kitura
import SwiftyJSON

struct PocketItemParser: ParserDecoderType {
    typealias Parsable = PocketItemType
    
    static func parse(body: ParsedBody) -> Parsable? {
        switch body {
        case .Json(let json):
            return PocketItemParser.decode(json: json)
        default:
            return nil
        }
    }
    
    static func decode(json: JSON) -> Parsable? {
        // TODO: Implement
        return nil
    }
}