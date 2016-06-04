//
//  SlackHandler.swift
//  Slacket
//
//  Created by Jakub Tomanik on 01/06/16.
//
//

import Foundation

import Kitura
import HeliumLogger
import LoggerAPI

enum SlacketAction: HandlerAction {
    
    case addCommand
    case authorizePocket
    
    static func from(route: String) -> SlacketAction? {
        switch route {
        case SlacketAction.addCommand.route:
            SlacketAction.addCommand
        case SlacketAction.authorizePocket.route:
            SlacketAction.authorizePocket
        default:
            return nil
        }
        return nil
    }
    
    var route: String {
        switch self {
        case .addCommand:
            return "api/v1/slack"
        case .authorizePocket:
            return "api/v1/pocket/auth"
        }
    }
    
    var method: Kitura.RouterMethod {
        switch self {
        case .addCommand:
            return .Post
        case .authorizePocket:
            return .Get
        }
    }
    
    var requiredBodyType: ParsedBody? {
        switch self {
        case .addCommand:
            return ParsedBody.UrlEncoded([:])
        case .authorizePocket:
            return nil
        }
    }
}

struct SlacketHandler: Handler, RouterMiddleware, ErrorType {
    
    static let errorDomain = "SlacketUserService"
    
    func handle(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        Log.debug("\(self.dynamicType.errorDomain) handler")
        
        guard let action = SlacketAction(request: request) else {
                let errorMessage = "Preconditions not met"
                Log.error(errorMessage)
                response.error = self.getError(message: errorMessage)
                next()
                return
        }
        
        switch action {
        case .addCommand:
            let view = SlacketView(response: response)
            if let slackCommand: SlackCommandType = SlackCommandParser.parse(body: request.body) {
                
                SlacketService.process(request: slackCommand) { slackMessage in
                    view.show(message: slackMessage)
                }
            }
            
        case .authorizePocket:
            PocketAuthorizationHandler().handle(request: request, response: response, next: next)

        }
    }
}