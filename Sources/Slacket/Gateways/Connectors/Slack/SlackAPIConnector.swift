//
//  SlackAPIConnector.swift
//  Slacket
//
//  Created by Jakub Tomanik on 03/06/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI
import SimpleHttpClient

protocol SlackConnectorType {
    
    static func send(message: SlackMessageType, inResponse command: SlackCommandType, completion: ((Bool) -> Void)?)
}

struct SlackApiConnector: SlackConnectorType {
    
    static func send(message: SlackMessageType, inResponse command: SlackCommandType, completion: ((Bool) -> Void)? = nil) {
        let slackEndpoint = SlackAPI.respond(command: command, message: message)
        slackEndpoint.request { error, status, headers, data in
            guard let status = status else {
                Log.error("status is nil")
                fatalError()
            }
            
            if 200...299 ~= status {
                completion?(true)
            } else {
                completion?(false)
            }
        }
    }
}