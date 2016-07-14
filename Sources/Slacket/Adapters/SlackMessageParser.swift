//
//  SlackMessageParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation

import Foundation
import Kitura
import SwiftyJSON

private extension SlackMessageVisibility {
    
    var slackValue: String {
        switch self {
            case .ephemeral:
                return "ephemeral"
            case .inChannel:
                return "in_channel"
        }
    }
}

struct SlackMessageParser: ParserEncoderType {
    
    typealias Parsable = SlackMessageType
    typealias ParsedType = JsonType
    
    static func encode(model: Parsable) -> ParsedType? {
        var dictionary = [String: String]()
        dictionary["text"] = model.text
        dictionary["response_type"] = model.responseVisibility.slackValue
        
        #if os(Linux)
            return JSON(dictionary as Any)
        #else
            return JSON(dictionary as AnyObject)
        #endif
    }
}