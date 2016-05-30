//
//  SlackCommandService.swift
//  Slacket
//
//  Created by Jakub Tomanik on 24/05/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

struct SlackResponseService: UserInfoServiceType {
    
    static let userInfoKey = "SLACK_RESPONSE"
    static let errorDomain = "SlackResponseService"
    
    func handle(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        Log.debug("\(self.dynamicType.errorDomain) handler")
        
        guard let slackResponse = request.slackResponse else {
            let errorMessage = "Preconditions not met"
            Log.error(errorMessage)
            response.error = self.getError(message: errorMessage)
            next()
            return
        }
        
        do {
            
            Log.debug("Responding")
            response.setHeader("Content-Type", value: "text/plain; charset=utf-8")
            try response.status(.OK).send(slackResponse.text).end()
        }
        catch {}
        return
    }
}

extension RouterRequest {
    
    var slackResponse: SlackResponseType? {
        get {
            return userInfo[SlackResponseService.userInfoKey] as? SlackResponseType
        }
        set {
            userInfo[SlackResponseService.userInfoKey] = newValue
        }
    }
}