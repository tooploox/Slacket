//
//  SlacketUserService.swift
//  Slacket
//
//  Created by Jakub Tomanik on 25/05/16.
//
//

import Foundation
import LoggerAPI

protocol SlacketServiceProvider {
    
    static func process(request: SlackCommandType, respond: ((SlackMessageType?) -> ()))
}

struct SlacketService: SlacketServiceProvider {
    
    static let errorDomain = "SlacketUserService"
    
    static func process(request: SlackCommandType, respond: ((SlackMessageType?) -> ())) {
        
        if let slacketUser = SlacketUserDataStore.sharedInstance.get(keyId: request.userId) where slacketUser.pocketAccessToken != nil,
        let command = request.command.withoutPercentEncoding(),
        let text = request.text.withoutPercentEncoding() {
            let message = SlackMessage(responseVisibility: .ephemeral,
                                       text: "\(command) \(text)")
            respond(message)
            
            var url = request.text.trimWhitespace()
            if !url.hasPrefix("http") {
                url = "http://" + url
            }
            PocketApiConnector.addLink(url: url,
                                       tags: [request.teamDomain, request.channelName],
                                       user: slacketUser) { pocketItem in
                                        guard pocketItem != nil else {
                                            Log.error("pocketItem is nil")
                                            respond(nil)
                                            return
                                        }
                                        
                                        let slackMessage = SlackMessage(responseVisibility: .ephemeral, text: "successfully added link")
                                        respond(slackMessage)
                                        SlackApiConnector.send(message: slackMessage, inResponse: request)
            }
        } else {
            let newUser = SlacketUser(slackId: request.userId,
                                      slackTeamId: request.teamId,
                                      pocketAccessToken: nil,
                                      pocketUsername: nil)
            let result = SlacketUserDataStore.sharedInstance.set(data: newUser)
            let userMessage = result ? "Please go to \(PocketAuthorizationAction.authorizationRequest.redirectUrl(user: newUser))" : "Ooops... there was an internal error"
            let message = SlackMessage(responseVisibility: .ephemeral, text: userMessage)
            respond(message)
        }
    }
}