//
//  PocketAddService.swift
//  SampleServer
//
//  Created by Jakub Tomanik on 24/05/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI
import SimpleHttpClient

struct PocketAddService: UserInfoServiceType {
    
    static let userInfoKey = "Pocket_RESPONSE"
    let errorDomain = "PocketAddService"
    
    func handle(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        Log.debug("\(self.errorDomain) handler")
        
        guard let command = request.slackCommand,
            let slacketUser = request.slacketUser else {
                let errorMessage = "Preconditions not met"
                Log.error(errorMessage)
                response.error = self.getError(message: errorMessage)
                next()
                return
        }
    
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            let url = command.text.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " "))
        #else
            let url = command.text.trimmingCharacters(in: NSCharacterSet(charactersIn: " "))
        #endif
        
        let requestData = PocketAddRequest(url: url,
                                    accessToken: slacketUser.pocketAccessToken,
                                    title: nil,
                                    tags: [command.teamDomain, command.channelName],
                                    tweetId: nil)
        
        PocketAPIClient.Add(requestData).request() { error, status, headers, data in
            guard let status = status else {
                fatalError()
            }
            
            if 200...299 ~= status {
                Log.debug("Successfull call to Pocket API")
                request.slackResponse = SlackResponse(responseVisibility: .Ephemeral, text: "successfully added link")
                next()
                return
                
            } else if let _ = error {
                let errorMessage = "Pocket API returned error"
                Log.error(errorMessage)
                response.error = self.getError(message: errorMessage)
                next()
                return
            }
            
            next()
            return
        }
    }
}