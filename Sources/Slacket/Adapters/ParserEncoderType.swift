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

protocol ParserEncoderType: ParserType {

    static func parse(model: Parsable) -> ParsedBody?
    static func encode(model: Parsable) -> ParsedType?
}

extension ParserEncoderType where ParsedType == JsonType {
    
    static func parse(model: Parsable) -> ParsedBody? {
        guard let json = self.encode(model: model) else {
            return nil
        }
        return ParsedBody.Json(json)
    }
}

extension ParserEncoderType where ParsedType == DictionaryType {
    
    static func parse(model: Parsable) -> ParsedBody? {
        guard let dict = self.encode(model: model) else {
            return nil
        }
        return ParsedBody.UrlEncoded(dict)
    }
}

extension ParserEncoderType where ParsedType == TextType {
    
    static func parse(model: Parsable) -> ParsedBody? {
        guard let text = self.encode(model: model) else {
            return nil
        }
        return ParsedBody.Text(text)
    }
}