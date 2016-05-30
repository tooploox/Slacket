//
//  PocketAuthorizationResponseParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation
import Kitura
import SwiftyJSON

struct PocketAuthorizationResponseParser: ParserDecoderType {
    typealias Parsable = PocketAuthorizationResponseType
    
    static func parse(body: ParsedBody) -> Parsable? {
        switch body {
        case .UrlEncoded(let parameters):
            return PocketAuthorizationResponseParser.decode(parameters: parameters)
        case .Json(let json):
            return PocketAuthorizationResponseParser.decode(json: json)
        default:
            return nil
        }
    }
    
    static func decode(parameters: [String : String]) -> Parsable? {
        if let requestToken = parameters["code"] {
            return PocketAuthorizationResponse(pocketRequestToken: requestToken)
        } else {
            return nil
        }
    }
    
    static func decode(json: JSON) -> Parsable? {
        if let requestToken = json["code"].string {
            return PocketAuthorizationResponse(pocketRequestToken: requestToken)
        } else {
            return nil
        }
    }
}
