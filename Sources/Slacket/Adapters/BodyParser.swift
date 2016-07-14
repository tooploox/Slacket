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
import LoggerAPI

extension ParsedBody {
    
    var isUTF8: Bool {
        return true
    }
    
    var contentType: String {
        switch self {
            case .text:
                return "text/plain"
            case .urlEncoded:
                return "application/x-www-form-urlencoded"
            case .json:
                return "application/json"
            case .multipart:
                return "multipart/mixed"
            case raw:
                return "application/binary"
        }
    }
    
    var contentTypeHeaderKey: String {
        return "Content-Type"
    }
    
    var contentTypeHeaderValue: String {
        var contentType = self.contentType
        contentType += self.isUTF8 ? "; charset=utf-8" : ""
        return contentType
    }
    
    var header: [String: String] {
        return [self.contentTypeHeaderKey: self.contentTypeHeaderValue]
        
    }
    
    var data: NSData? {
        switch self {
            case .text(let text):
                return self.encode(text: text)
            case .urlEncoded(let parameters):
                return self.encode(parameters: parameters)
            case .json(let json):
                return self.encode(json: json)
            case .multipart(let parts):
                return self.encode(multipart: parts)
            case .raw(let data):
                return data
        }
    }
    
    init?(data: NSData, contentType contentTypeString: String?) {
        guard let contentTypeString = contentTypeString else {
            Log.debug(AdapterError.parsedBodyNilContentTypeString)
            return nil
        }
        
        if contentTypeString.startsWith(prefix: "text/plain"), let text = String(data: data, encoding: NSUTF8StringEncoding) {
            self = .text(text)
        } else if contentTypeString.startsWith(prefix: "application/x-www-form-urlencoded"),
            let text = String(data: data, encoding: NSUTF8StringEncoding) {
            var params = [String: String]()
            let pairs = text.separatedComponents(separatedBy: "&")
            for pair in pairs {
                let keyValue = pair.separatedComponents(separatedBy: "=")
                if keyValue.count > 1 {
                    params.updateValue(keyValue[1], forKey: keyValue[0])
                }
            }
            self = .urlEncoded(params)
        } else if contentTypeString.startsWith(prefix: "application/json") {
            let json = JSON(data: data)
            if json != JSON.null {
                self = .json(json)
            } else {
                Log.debug(AdapterError.parsedBodyFailedJsonSerialization)
                return nil
            }
        } else {
            Log.debug(AdapterError.parsedBodyFailedParsingContentType)
            return nil
        }
    }
    
    private func encode(json: JSON) -> NSData? {
        return try? json.rawData()
    }
    
    private func encode(parameters: [String: String]) -> NSData? {
        let parametersArray = parameters.map { "\($0.key)=\($0.value)" }
        let parametersString = parametersArray.joinedBy(separator: "&")
        return self.encode(text: parametersString)
    }
    
    private func encode(text: String) -> NSData? {
        return text.encodedData
    }
    
    private func encode(multipart parts: [Part]) -> NSData? {
        // TODO: - encode implementation
        Log.debug(AdapterError.parsedBodyEncodeUnimplemented)
        return nil
    }
}