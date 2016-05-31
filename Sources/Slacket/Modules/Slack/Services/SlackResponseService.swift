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

struct SlackMessageService: UserInfoServiceType {
    
    static let userInfoKey = "SLACK_RESPONSE"
    static let errorDomain = "SlackMessageService"
    
    func handle(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        Log.debug("\(self.dynamicType.errorDomain) handler")
        
        guard let SlackMessage = request.SlackMessage else {
            let errorMessage = "Preconditions not met"
            Log.error(errorMessage)
            response.error = self.getError(message: errorMessage)
            next()
            return
        }
        
        do {
            
            Log.debug("Responding")
            response.setHeader("Content-Type", value: "text/plain; charset=utf-8")
            try response.status(.OK).send(SlackMessage.text).end()
        }
        catch {}
        return
    }
}

extension RouterRequest {
    
    var SlackMessage: SlackMessageType? {
        get {
            return userInfo[SlackMessageService.userInfoKey] as? SlackMessageType
        }
        set {
            userInfo[SlackMessageService.userInfoKey] = newValue
        }
    }
}