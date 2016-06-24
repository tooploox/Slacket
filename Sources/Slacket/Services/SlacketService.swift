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
    
    static func process(request: SlackCommandType, respond: ((SlackMessageType) -> ()))
}

struct SlacketService: SlacketServiceProvider {
    
    static let errorDomain = "SlacketUserService"
    
    static func process(request: SlackCommandType, respond: ((SlackMessageType) -> ())) {
        
        if let slacketUser = SlacketUserDataStore.sharedInstance.get(keyId: request.userId) where slacketUser.pocketAccessToken != nil {
            let message = SlackMessage(responseVisibility: .ephemeral,
                                       text: "\(request.command) \(request.text)")
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
                                            fatalError()
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
            let _ = SlacketUserDataStore.sharedInstance.set(data: newUser)
            let message = SlackMessage(responseVisibility: .ephemeral,
                                       text: "Please go to \(PocketAuthorizationAction.authorizationRequest.redirectUrl(user: newUser))")
            respond(message)
        }
    }
}