//
//  AdapterError.swift
//  Slacket
//
//  Created by Bartłomiej Nowak on 11/07/16.
//
//

import Foundation

enum AdapterError: ErrorProtocol, DescribableError {
    case parsedBodyNilContentTypeString
    case parsedBodyFailedJsonSerialization
    case parsedBodyFailedParsingContentType
    case parsedBodyEncodeUnimplemented
    case parserDecoderTypeNilBody
    case parserDecoderTypeUnsupportedBodyType
    case parserEncoderTypeFailedEncoding
    case slackCommandParserFailedDecoding(SlackCommandParser.ParsedType)
    case slacketUserParserFailedDecoding(SlacketUserParser.ParsedType)
    
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
            case .parserDecoderTypeNilBody:
                return "ParserDecoderType body is nil"
            case .parserDecoderTypeUnsupportedBodyType:
                return "ParserDecoderType unsupported body type"
            case .parserEncoderTypeFailedEncoding:
                return "ParserEncoderType failed encoding Parsable"
            case .slackCommandParserFailedDecoding(let parsedType):
                return "SlackCommandParser failed decoding ParsedType \(parsedType)"
            case .slacketUserParserFailedDecoding(let parsedType):
                return "SlacketUserParser failed decoding SlacketUser \(parsedType)"
        }
    }
}