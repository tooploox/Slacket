//
//  SlacketUserService.swift
//  Slacket
//
//  Created by Jakub Tomanik on 25/05/16.
//
//

import Foundation

protocol SlacketServiceProvider {
    
    static func process(request: SlackCommandType, respond: (SlackMessageType -> ()))
}

struct SlacketService: SlacketServiceProvider {
    
    static let errorDomain = "SlacketUserService"
    
    static func process(request: SlackCommandType, respond: (SlackMessageType -> ())) {
        
        if let slacketUser = SlacketUserDataStore.sharedInstance.get(keyId: request.userId) where slacketUser.pocketAccessToken != nil {
            
            let message = SlackMessage(responseVisibility: .Ephemeral,
                                       text: "\(request.command) \(request.text)")
            respond(message)
            
            let url = request.text.trimWhitespace()
            PocketApiConnector.addLink(url: url,
                                       tags: [request.teamDomain, request.channelName],
                                       user: slacketUser) { pocketItem in
                                        guard let pocketItem = pocketItem else {
                                            fatalError()
                                        }
                                        
                                        let slackMessage = SlackMessage(responseVisibility: .Ephemeral, text: "successfully added link")
                                        SlackApiConnector.send(message: slackMessage, inResponse: request)
            }
            
        } else {
            
            let newUser = SlacketUser(slackId: request.userId,
                                      slackTeamId: request.teamId,
                                      pocketAccessToken: nil,
                                      pocketUsername: nil)
            SlacketUserDataStore.sharedInstance.set(data: newUser)
            let message = SlackMessage(responseVisibility: .Ephemeral,
                                       text: "Please go to \(PocketAuthorizationAction.authorizationRequest.redirectUrl(user: newUser))")
            respond(message)
        }
    }
}