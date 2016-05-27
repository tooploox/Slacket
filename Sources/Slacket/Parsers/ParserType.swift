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
protocol ParserType {}

protocol ParserDecoder: ParserType {
    
    associatedtype Parsable
    func parse(body: ParsedBody) -> Parsable
}

protocol ParserEncoder: ParserType {
    
    func parse(model: Parsable) -> ParsedBody
}
