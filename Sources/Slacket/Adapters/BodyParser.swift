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
            return "application/x-www-form-urlencoded"
        case .Json:
            return "application/json"
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
    
    init?(data: NSData, contentType contentTypeString: String?) {
        guard let contentTypeString = contentTypeString else {
            return nil
        }
        
        if contentTypeString.startsWith(prefix: "text/plain"), let text = String(data: data, encoding: NSUTF8StringEncoding) {
            self = .Text(text)
        } else if contentTypeString.startsWith(prefix: "application/x-www-form-urlencoded"),
            let text = String(data: data, encoding: NSUTF8StringEncoding) {
            var params = [String: String]()
            let pairs = text.components(separatedBy: "&")
            for pair in pairs {
                let keyValue = pair.components(separatedBy: "=")
                if keyValue.count > 1 {
                    params.updateValue(keyValue[1], forKey: keyValue[0])
                }
            }
            self = .UrlEncoded(params)
        } else if contentTypeString.startsWith(prefix: "application/json") {
            let json = JSON(data: data)
            if json != JSON.null {
                self = .Json(json)
            } else {
                return nil
            }
        } else {
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
}