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

struct PocketAccessTokenResponseParser: ParserDecoderType {
    typealias Parsable = PocketAccessTokenResponseType
    
    static func parse(body: ParsedBody) -> Parsable? {
        switch body {
        case .UrlEncoded(let parameters):
            return PocketAccessTokenResponseParser.decode(parameters: parameters)
        case .Json(let json):
            return PocketAccessTokenResponseParser.decode(json: json)
        default:
            return nil
        }
    }
    
    static func decode(parameters: [String : String]) -> Parsable? {
        if let accessToken = parameters["access_token"],
            let username = parameters["username"] {
            return PocketAccessTokenResponse(pocketAccessToken: accessToken, pocketUsername: username)
        } else {
            return nil
        }
    }
    
    static func decode(json: JSON) -> Parsable? {
        if let accessToken = json["access_token"].string,
            let username = json["username"].string {
            return PocketAccessTokenResponse(pocketAccessToken: accessToken, pocketUsername: username)
        } else {
            return nil
        }
    }
}
