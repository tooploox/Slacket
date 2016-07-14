//
//  ConnectorError.swift
//  Slacket
//
//  Created by Bartłomiej Nowak on 11/07/16.
//
//

import Foundation

enum ConnectorError: ErrorProtocol, DescribableError {
    enum ApiType: String {
        case Slack
        case Pocket
    }
    
    case missingAccessToken
    case missingStatus(for: ApiType)
    case nilDataParsedBodyOrAccessTokenResponse
    case addRequestNilUrl
    case connectorProviderUnsupportedMethod
    case addResponseCouldntDecode
    case pocketItemParserCouldntDecode
    case pocketAuthorizationHandlerActionCouldntInit
    case pocketAuthorizationActionNilRoute
    case pocketAuthorizationActionUnsupportedRoute
    case pocketAuthorizationHandlerSlacketUser
    case pocketAuthorizationHandlerRedirectUrl
    case pocketAuthorizationRequestService
    case pocketAuthorizationResponseParser
    case pocketAuthorizeApiNilContentType
    case pocketAuthorizeApiNilRedirectUrl
    case pocketAccessTokenRequestService
    case pocketAccessTokenResponseParser
    
    var description: String {
        switch self {
            case .missingAccessToken:
                return "PocketApiConnector access token is nil"
            case .missingStatus(let apiType):
                return "\(apiType.rawValue)ApiConnector request status is nil or status != 1"
            case .nilDataParsedBodyOrAccessTokenResponse:
                return "PocketApiConnector data, parsedBody or accessTokenResponse is nil"
            case .connectorProviderUnsupportedMethod:
                return "ConnectorProvider unsupported endpoint method case"
            case .addRequestNilUrl:
                return "PocketAddRequest URL is nil"
            case .addResponseCouldntDecode:
                return "PocketAddResponse failed decoding"
            case .pocketItemParserCouldntDecode:
                return "PocketItemParser failed decoding"
            case .pocketAuthorizationHandlerActionCouldntInit:
                return "PocketAuthorizationHandler couldnt init PocketAuthorizationAction"
            case .pocketAuthorizationActionNilRoute:
                return "PocketAuthorizationAction route is nil"
            case .pocketAuthorizationActionUnsupportedRoute:
                return "PocketAuthorizationAction unsupported route type"
            case .pocketAuthorizationHandlerSlacketUser:
                return "PocketAuthorizationHandler slacketUser or .pocketAccessToken is nil"
            case .pocketAuthorizationHandlerRedirectUrl:
                return "PocketAuthorizationHandler redirectUrl is nil"
            case .pocketAuthorizationRequestService:
                return "PocketAuthorizationRequestService authorizationResponse or redirectUrl is nil"
            case .pocketAuthorizationResponseParser:
                return "PocketAuthorizationResponseParser failed decoding"
            case pocketAuthorizeApiNilContentType:
                return "PocketAuthorizeAPI ContentType is nil"
            case pocketAuthorizeApiNilRedirectUrl:
                return "PocketAuthorizeAPI RedirectUrl is nil"
            case .pocketAccessTokenRequestService:
                return "PocketAccessTokenRequestService user or authData is nil"
            case .pocketAccessTokenResponseParser:
                return "PocketAccessTokenResponseParser failed decoding"
        }
    }
}