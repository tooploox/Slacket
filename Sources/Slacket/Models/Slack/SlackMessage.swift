//
//  SlackMessage.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

// See: https://api.slack.com/slash-commands

enum SlackMessageVisibility {
    
    case Ephemeral // Visible only to user that issued the command
    case InChannel // Visible to all members of the channel in which user typed the command
}

// https://api.slack.com/docs/formatting

protocol SlackMessageType: class {
    
    var responseVisibility: SlackMessageVisibility { get }
    var text: String { get }
}

class SlackMessage: SlackMessageType {

    let responseVisibility: SlackMessageVisibility
    let text: String
    
    init(responseVisibility: SlackMessageVisibility,
         text: String) {
        
        self.responseVisibility = responseVisibility
        self.text = text
    }
}