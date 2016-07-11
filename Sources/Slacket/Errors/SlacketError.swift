//
//  SlacketError.swift
//  Slacket
//
//  Created by Bartłomiej Nowak on 11/07/16.
//
//

import Foundation

enum SlacketError: ErrorProtocol, DescribableError {
    case pocketAuthorization
    case pocketUnknown
    case pocketMissingConsumerKey
    case slackMissingToken
    case connectorProviderUnsupportedMethod
    
    var description: String {
        switch self {
            case .pocketAuthorization:
                return "Your Pocket account could not be linked because the Pocket server denied authorization"
            case .pocketUnknown:
                return "Something went wrong...</br>and we don't know what :("
            case .pocketMissingConsumerKey:
                return "Cannot find POCKET_CONSUMER_KEY environmental variable"
            case .slackMissingToken:
                return "Slack missing SLACK_TOKEN environmental variable"
            case .connectorProviderUnsupportedMethod:
                return "Unsupported connector endpoint method case"
        }
    }
}

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