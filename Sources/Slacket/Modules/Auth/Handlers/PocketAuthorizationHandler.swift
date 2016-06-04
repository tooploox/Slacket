//
//  PocketAuthorizationHandler.swift
//  Slacket
//
//  Created by Jakub Tomanik on 03/06/16.
//
//

import Foundation

import Kitura
import HeliumLogger
import LoggerAPI

enum PocketAuthorizationAction: HandlerAction, ServerConfig {
    
    case authorizationRequest
    case accessTokenRequest
    
    static func from(route: String) -> PocketAuthorizationAction? {
        switch route {
        case PocketAuthorizationAction.authorizationRequest.route:
            PocketAuthorizationAction.authorizationRequest
        case PocketAuthorizationAction.accessTokenRequest.route:
            PocketAuthorizationAction.accessTokenRequest
        default:
            return nil
        }
        return nil
    }
    
    var route: String {
        switch self {
        case .authorizationRequest:
            return "api/v1/pocket/auth/request"
        case .accessTokenRequest:
            return "api/v1/pocket/auth/respond"
        }
    }
    
    var method: Kitura.RouterMethod {
        return .Post
    }
    
    var requiredParameters: [String]? {
        return ["user", "team"]
    }
    
    func redirectUrl(user: SlacketUserType) -> String {
        return "\(self.schema.rawValue)://\(self.host)/\(self.route)?user=\(user.slackId)&team=\(user.slackTeamId)"
    }
}

struct PocketAuthorizationHandler: Handler, ErrorType {
    
    static let errorDomain = "PocketAuthorizationHandler"
    
    func handle(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        Log.debug("\(self.dynamicType.errorDomain) handler")
        
        guard let action = PocketAuthorizationAction(request: request) else {
            let errorMessage = "Preconditions not met"
            Log.error(errorMessage)
            response.error = self.getError(message: errorMessage)
            next()
            return
        }
        let parsedBody = request.queryParams
        
        switch action {
        case .authorizationRequest:
            let view = RedirectView(response: response)
            
            if let slacketUser = SlacketUserParser.parse(body: ParsedBody.UrlEncoded(parsedBody)) where slacketUser.pocketAccessToken == nil {
                PocketAuthorizationRequestService.process(user: slacketUser) { redirectUrl in
                    guard let redirectUrl = redirectUrl else {
                        fatalError()
                    }
                    view.redirect(to: redirectUrl)
                }
            }
            
        case .accessTokenRequest:
            let view = AuthorizeView(response: response)
            
            if let slacketUser = SlacketUserParser.parse(body: ParsedBody.UrlEncoded(parsedBody)) where slacketUser.pocketAccessToken == nil,
                let user = slacketUser as? SlacketUser{
                PocketAccessTokenRequestService.process(user: slacketUser) { accessTokenResponse in
                    guard let accessTokenResponse = accessTokenResponse else {
                        fatalError()
                    }
                    let fullSlacketUser = SlacketUser(slackId: user.slackId,
                                                      slackTeamId:  user.slackTeamId,
                                                      pocketAccessToken: accessTokenResponse.pocketAccessToken,
                                                      pocketUsername: accessTokenResponse.pocketUsername)
                    SlacketUserDataStore.sharedInstance.set(data: fullSlacketUser)
                    view.show(message: "Authorized")
                }
            }
        }
    }
}