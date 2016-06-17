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
    
    case ephemeral // Visible only to user that issued the command
    case inChannel // Visible to all members of the channel in which user typed the command
}

// https://api.slack.com/docs/formatting

protocol SlackMessageType {
    
    var responseVisibility: SlackMessageVisibility { get }
    var text: String { get }
}

struct SlackMessage: SlackMessageType {

    let responseVisibility: SlackMessageVisibility
    let text: String
}