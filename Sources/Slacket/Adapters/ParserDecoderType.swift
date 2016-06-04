//
//  ParserDecoderType.swift
//  Slacket
//
//  Created by Jakub Tomanik on 20/05/16.
//
//

import Foundation
import Kitura
import SwiftyJSON

protocol ParserDecoderType: ParserType {

    static func parse(body: ParsedBody?) -> Parsable?
    static func decode(raw: ParsedType) -> Parsable?
}

extension ParserDecoderType where ParsedType == JsonType {
    
    static func parse(body: ParsedBody?) -> Parsable? {
        guard let body = body else {
            return nil
        }
        switch body {
        case .Json(let json):
            return self.decode(raw: json)
        default:
            return nil
        }
    }
}

extension ParserDecoderType where ParsedType == DictionaryType {
    
    static func parse(body: ParsedBody?) -> Parsable? {
        guard let body = body else {
            return nil
        }
        switch body {
        case .UrlEncoded(let dict):
            return self.decode(raw: dict)
        default:
            return nil
        }
    }
}

extension ParserDecoderType where ParsedType == TextType {
    
    static func parse(body: ParsedBody?) -> Parsable? {
        guard let body = body else {
            return nil
        }
        switch body {
        case .Text(let text):
            return self.decode(raw: text)
        default:
            return nil
        }
    }
}