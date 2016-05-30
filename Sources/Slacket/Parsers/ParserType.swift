//
//  ParserType.swift
//  Slacket
//
//  Created by Jakub Tomanik on 20/05/16.
//
//

import Foundation
import Kitura
import SwiftyJSON

// To define parsers
protocol ParserType {
    
    // not sure if this will work, had errors when did the same in DataStore
    associatedtype Parsable
}

protocol ParserDecoderType: ParserType {

    static func parse(body: ParsedBody) -> Parsable?
}

protocol ParserEncoderType: ParserType {

    static func parse(model: Parsable) -> ParsedBody?
}