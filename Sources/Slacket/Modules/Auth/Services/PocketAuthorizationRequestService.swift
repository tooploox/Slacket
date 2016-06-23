//
//  PocketAuthorizationRequestService.swift
//  Slacket
//
//  Created by Jakub Tomanik on 24/05/16.
//
//

import Foundation

typealias RedirectUrl = String

protocol PocketAuthorizationRequestServiceProvider {
    
    static func process(user: SlacketUserType, respond: (RedirectUrl?) -> Void )
}

struct PocketAuthorizationRequestService: PocketAuthorizationRequestServiceProvider {
    
    static let errorDomain = "PocketAuthorizationRequestService"
    
    static func process(user: SlacketUserType, respond: (RedirectUrl?) -> Void ) {
        guard let user = user as? SlacketUser else {
            respond(nil)
            return
        }
        
        let redirectUrl = PocketAuthorizationAction.accessTokenRequest.redirectUrl(user: user)
        PocketAuthorizeAPIConnector.requestAuthorization(redirectUrl: redirectUrl) { response in
            guard let (authorizationResponse, redirectUrl) = response else {
                respond(nil)
                return
            }
            let authorizationData = PocketAuthorizationData(id: user.keyId,
                                                            requestToken: authorizationResponse.pocketRequestToken)
            PocketAuthorizationDataStore.sharedInstance.set(data: authorizationData)
            respond(redirectUrl)
        }
    }
}