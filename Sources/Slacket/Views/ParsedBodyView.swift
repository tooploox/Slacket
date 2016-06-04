//
//  JSONView.swift
//  Slacket
//
//  Created by Jakub Tomanik on 01/06/16.
//
//

import Foundation
import Kitura
import SwiftyJSON
import HeliumLogger
import LoggerAPI

protocol ParsedBodyResponder: ViewResponder {
    
    func show(body: ParsedBody)
}

extension ParsedBodyResponder {
    
    func show(body: ParsedBody) {
        response.status(.OK)
        response.setHeader(body.contentTypeHeaderKey, value: body.contentTypeHeaderValue)
        switch body {
        case .Json(let json):
            response.send(json.description)
        case .UrlEncoded(let dict):
            let keyValue = dict.map { "\($0.0)=\($0.1)" }
            let joined = keyValue.joinedBy(separator: "&")
            response.send(joined)
        case .Text(let text):
            response.send(text)
        }
        
        do {
            try response.end()
        }
        catch {
            Log.error("Failed to send response \(error)")
        }
    }
}