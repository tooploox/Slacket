//
//  ParserType.swift
//  Slacket
//
//  Created by Jakub Tomanik on 20/05/16.
//
//

import Foundation
import Kitura

// To define parsers
protocol ParserType {
    
    // not sure if this will work, had errors when did the same in DataStore
    associatedtype Parsable
}

protocol ParserDecoder: ParserType {

    func parse(body: ParsedBody) -> Parsable
}

protocol ParserEncoder: ParserType {

    func parse(model: Parsable) -> ParsedBody
}
