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
        response.headers.append(body.contentTypeHeaderKey, value: body.contentTypeHeaderValue)
        switch body {
            case .json(let json):
                response.send(json.description)
            case .urlEncoded(let dict):
                let keyValue = dict.map { "\($0.0)=\($0.1)" }
                let joined = keyValue.joinedBy(separator: "&")
                response.send(joined)
            case .text(let text):
                response.send(text)
            case .raw(let data):
                response.send(data: data)
            case .multipart:
                break
        }
        
        do {
            try response.end()
        } catch {
            Log.error(ViewError.responseSendFailure(for: error))
        }
    }
}