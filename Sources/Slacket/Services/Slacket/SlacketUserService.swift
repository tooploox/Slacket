//
//  SlacketUserService.swift
//  Slacket
//
//  Created by Jakub Tomanik on 25/05/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

struct SlacketUserService: UserInfoServiceType {

    static let userInfoKey = "SLACKET_USER"
    static let errorDomain = "SlacketUserService"
    
    func handle(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        Log.debug("\(self.dynamicType.errorDomain) handler")
        
        guard let command = request.slackCommand else {
            let errorMessage = "Preconditions not met"
            Log.error(errorMessage)
            response.error = self.getError(message: errorMessage)
            next()
            return
        }
        
        if let slacketUser = SlacketUserDataStore.sharedInstance.get(keyId: command.userId) {
            
            request.slacketUser = slacketUser
            next()
            
        } else {

            request.SlackMessage = SlackMessage(responseVisibility: .Ephemeral,
                                                  text: "Please go to \(PocketAuthorizationEndpoint.Request.directToUrl(id: command.userId))")
            next()
        }
    }
}

extension RouterRequest {
    
    var slacketUser: SlacketUserType? {
        get {
            return userInfo[SlacketUserService.userInfoKey] as? SlacketUserType
        }
        set {
            userInfo[SlacketUserService.userInfoKey] = newValue
        }
    }
}