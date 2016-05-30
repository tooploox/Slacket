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
import Socket

extension NSData: SocketReader {
    
    public func readString() throws -> String? {
        
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            return String(data: self, encoding: NSUTF8StringEncoding)
        #else
            return String(data: self, encoding: NSUTF8StringEncoding)
        #endif
    }
    
    public func read(into data: NSMutableData) throws -> Int {
        
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            return try self.read(into: data)
        #else
            return try self.read(into: data)
        #endif
    }
}

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
    
    var header: [String: String] {
        var contentType = self.contentType
        contentType += self.isUTF8 ? "; charset=utf-8" : ""
        return ["Content-Type": contentType]
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
        
        
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            let parametersString = parametersArray.componentsJoinedByString("&")
        #else
            let parametersString = parametersArray.joined(separator: "&")
        #endif
        return self.encode(text: parametersString)
    }
    
    private func encode(text: String) -> NSData? {
        
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            return text.dataUsingEncoding(NSUTF8StringEncoding)
        #else
            return text.data(using: NSUTF8StringEncoding)
        #endif
    }
}