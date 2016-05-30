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
    typealias ParsedType = JsonType
    
    static func decode(raw: ParsedType) -> Parsable? {
        // TODO: Implement
        return nil
    }
}