//
//  SlackCommandService.swift
//  SampleServer
//
//  Created by Jakub Tomanik on 24/05/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

enum SlackEndpoint: APIServiceEndpointType {
    case Command
    
    var routerMethod: RouterMethod {
        return .Post
    }
    
    var route: String {
        return "api/v1/slack/command"
    }
    
    var requiredBodyType: ParsedBody? {
        return ParsedBody.UrlEncoded([:])
    }
}

struct SlackCommandService: APIServiceType, UserInfoServiceType {
    
    static let userInfoKey = "SLACK_COMMAND"
    let errorDomain = "SlackCommandService"
    let endpoint: APIServiceEndpointType = SlackEndpoint.Command
    
    func handle(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        Log.debug("\(self.errorDomain) handler")
        
        guard let body = request.body,
            let command = SlackCommandRequestParser.parse(body: body) else {
            let errorMessage = "Preconditions not met"
            Log.error(errorMessage)
            response.error = self.getError(message: errorMessage)
            next()
            return
        }
        
        request.slackCommand = command
    }
}

extension RouterRequest {
    
    var slackCommand: SlackCommandRequestType? {
        get {
            return userInfo[SlackCommandService.userInfoKey] as? SlackCommandRequestType
        }
        set {
            userInfo[SlackCommandService.userInfoKey] = newValue
        }
    }
}