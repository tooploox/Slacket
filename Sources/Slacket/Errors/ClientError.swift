//
//  ClientError.swift
//  Slacket
//
//  Created by Bartłomiej Nowak on 11/07/16.
//
//

import Foundation

enum ClientError: ErrorProtocol, DescribableError {
    case parsedBodyNilContentTypeString
    case parsedBodyFailedJsonSerialization
    case parsedBodyFailedParsingContentType
    case parsedBodyEncodeUnimplemented
    
    var description: String {
        switch self {
        case .parsedBodyNilContentTypeString:
            return "ParsedBody.init? contentTypeString is nil"
        case .parsedBodyFailedJsonSerialization:
            return "ParsedBody.init? failed to serialize JSON from provided data"
        case .parsedBodyFailedParsingContentType:
            return "ParsedBody.init? failed to parse contentType"
        case .parsedBodyEncodeUnimplemented:
            return "ParsedBody.init? encode is unimplemented"
        }
    }
}