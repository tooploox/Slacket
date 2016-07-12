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
import LoggerAPI

protocol ParserDecoderType: ParserType {

    static func parse(body: ParsedBody?) -> Parsable?
    static func decode(raw: ParsedType) -> Parsable?
}

extension ParserDecoderType where ParsedType == JsonType {
    
    static func parse(body: ParsedBody?) -> Parsable? {
        guard let body = body else {
            Log.error(AdapterError.parserDecoderTypeNilBody)
            return nil
        }
        switch body {
            case .json(let json):
                return self.decode(raw: json)
            case .urlEncoded(let dict):
                #if os(Linux)
                    return self.decode(raw: JSON(dict as Any))
                #else
                    return self.decode(raw: JSON(dict as AnyObject))
                #endif
            default:
                Log.debug(AdapterError.parserDecoderTypeUnsupportedBodyType)
                return nil
        }
    }
}

extension ParserDecoderType where ParsedType == DictionaryType {
    
    static func parse(body: ParsedBody?) -> Parsable? {
        guard let body = body else {
            Log.error(AdapterError.parserDecoderTypeNilBody.description)
            return nil
        }
        switch body {
            case .urlEncoded(let dict):
                return self.decode(raw: dict)
            default:
                Log.debug(AdapterError.parserDecoderTypeUnsupportedBodyType)
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
            case .text(let text):
                return self.decode(raw: text)
            default:
                Log.debug(AdapterError.parserDecoderTypeUnsupportedBodyType)
                return nil
        }
    }
}