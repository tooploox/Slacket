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
    case pocketAddRequestNilUrl
    case pocketMissingConsumerKey
    case slackMissingToken
    case connectorProviderUnsupportedMethod
    
    var description: String {
        switch self {
            case .pocketAuthorization:
                return "Your Pocket account could not be linked because the Pocket server denied authorization"
            case .pocketUnknown:
                return "Something went wrong...</br>and we don't know what :("
            case .pocketAddRequestNilUrl:
                return "Pocket add request URL is nil"
            case .pocketMissingConsumerKey:
                return "Cannot find POCKET_CONSUMER_KEY environmental variable"
            case .slackMissingToken:
                return "Slack missing SLACK_TOKEN environmental variable"
            case .connectorProviderUnsupportedMethod:
                return "Unsupported connector endpoint method case"
        }
    }
}