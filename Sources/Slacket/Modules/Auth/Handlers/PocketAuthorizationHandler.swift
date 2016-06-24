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

enum PocketAuthorizationAction: HandlerAction {
    
    case authorizationRequest
    case accessTokenRequest
    
    static func from(route: String?) -> PocketAuthorizationAction? {
        guard let route = route else {
            Log.error("route is nil")
            return nil
        }
        switch route {
        case let r where r.startsWith(prefix: PocketAuthorizationAction.authorizationRequest.route):
            return PocketAuthorizationAction.authorizationRequest
        case let r where r.startsWith(prefix: PocketAuthorizationAction.accessTokenRequest.route):
            return PocketAuthorizationAction.accessTokenRequest
        default:
            Log.debug("Unsupported route case")
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .authorizationRequest:
            return SlacketAction.authorizePocket.path + "/request"
        case .accessTokenRequest:
            return SlacketAction.authorizePocket.path + "/respond"
        }
    }

    var route: String {
        return "/" + self.path
    }

    var method: RouterMethod {
        return .get
    }
    
    var requiredQueryParameters: [String]? {
        return ["user", "team"]
    }
    
    func redirectUrl(user: SlacketUserType) -> String {
        return "\(ExternalServerConfig().baseURL+self.path)?user=\(user.slackId)&team=\(user.slackTeamId)"
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
        let parsedBody = request.queryParameters
        
        switch action {
        case .authorizationRequest:
            let view = RedirectView(response: response)
            
            if let slacketUser = SlacketUserParser.parse(body: ParsedBody.urlEncoded(parsedBody)) where slacketUser.pocketAccessToken == nil {
                PocketAuthorizationRequestService.process(user: slacketUser) { redirectUrl in
                    guard let redirectUrl = redirectUrl else {
                        Log.error("redirectUrl is nil")
                        fatalError()
                    }
                    view.redirect(to: redirectUrl)
                }
            } else {
                Log.debug("slacketUser or slacketUser.pocketAccessToken is nil")
            }
            
        case .accessTokenRequest:
            let view = AuthorizeView(response: response)
            
            if let slacketUser = SlacketUserParser.parse(body: ParsedBody.urlEncoded(parsedBody)) where slacketUser.pocketAccessToken == nil,
                let user = slacketUser as? SlacketUser{
                PocketAccessTokenRequestService.process(user: slacketUser) { accessTokenResponse in
                    guard let accessTokenResponse = accessTokenResponse else {
                        Log.error("accessToken is nil")
                        fatalError()
                    }
                    let fullSlacketUser = SlacketUser(slackId: user.slackId,
                                                      slackTeamId:  user.slackTeamId,
                                                      pocketAccessToken: accessTokenResponse.pocketAccessToken,
                                                      pocketUsername: accessTokenResponse.pocketUsername)
                    let _ = SlacketUserDataStore.sharedInstance.set(data: fullSlacketUser)
                    view.show(message: "Authorized")
                }
            }
        }
    }
}