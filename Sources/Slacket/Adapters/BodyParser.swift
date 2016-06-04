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

extension ParsedBody {
    
    var isUTF8: Bool {
        return true
    }
    
    var contentType: String {
        switch self {
        case .Text:
            return "text/plain"
        case .UrlEncoded:
            return "application/json"
        case .Json:
            return "application/x-www-form-urlencoded"
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
        case .Text(let text):
            return self.encode(text: text)
        case .UrlEncoded(let parameters):
            return self.encode(parameters: parameters)
        case .Json(let json):
            return self.encode(json: json)
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
}