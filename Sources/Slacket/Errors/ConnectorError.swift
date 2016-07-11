//
//  ConnectorError.swift
//  Slacket
//
//  Created by Bartłomiej Nowak on 11/07/16.
//
//

import Foundation

enum ApiType: String {
    case Slack
    case Pocket
}

enum ConnectorError: ErrorProtocol, DescribableError {
    case missingAccessToken
    case missingStatus(for: ApiType)
    case nilDataParsedBodyOrAccessTokenResponse
    case addRequestNilUrl
    
    var description: String {
        switch self {
        case .missingAccessToken:
            return "PocketApiConnector access token is nil"
        case .missingStatus(let apiType):
            return "\(apiType.rawValue)ApiConnector request status is nil or status != 1"
        case .nilDataParsedBodyOrAccessTokenResponse:
            return "PocketApiConnector data, parsedBody or accessTokenResponse is nil"
        case .addRequestNilUrl:
            return "Pocket add request URL is nil"
        }
    }
}