//
//  SlackResponseParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation

import Foundation
import Kitura
import SwiftyJSON

private extension SlackResponseVisibility {
    
    var slackValue: String {
        switch self {
        case .Ephemeral:
            return "ephemeral"
        case .InChannel:
            return "in_channel"
        }
    }
}

struct SlackResponseParser: ParserEncoderType {
    typealias Parsable = SlackResponseType
    
    static func parse(model: Parsable) -> ParsedBody? {
        guard let json = SlackResponseParser.encode(model: model) else {
            return nil
        }
        
        return ParsedBody.Json(json)
    }
    
    static func encode(model: Parsable) -> JSON? {
        var dictionary = [String: String]()
        dictionary["text"] = model.text
        dictionary["response_type"] = model.responseVisibility.slackValue
        
        return JSON(dictionary)
    }
}