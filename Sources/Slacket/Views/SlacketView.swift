//
//  SlacketView.swift
//  Slacket
//
//  Created by Jakub Tomanik on 02/06/16.
//
//

import Foundation
import Kitura
import SwiftyJSON
import LoggerAPI

protocol SlacketViewResponder {
    
    func show(message: SlackMessageType)
}

struct SlacketView: SlacketViewResponder, ParsedBodyResponder {
    
    let response: RouterResponse
    
    func show(message: SlackMessageType) {
        if let parsed = SlackMessageParser.parse(model: message) {
            self.show(body: parsed)
        } else {
            Log.debug("parsed is nil")
        }
    }
}