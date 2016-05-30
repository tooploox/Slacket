//
//  SlackResponse.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

// See: https://api.slack.com/slash-commands

enum SlackResponseVisibility {
    
    case Ephemeral // Visible only to user that issued the command
    case InChannel // Visible to all members of the channel in which user typed the command
}

// https://api.slack.com/docs/formatting

protocol SlackResponseType: class, SlacketModel {
    
    var responseVisibility: SlackResponseVisibility { get }
    var text: String { get }
}

class SlackResponse: SlackResponseType {

    let responseVisibility: SlackResponseVisibility
    let text: String
    
    init(responseVisibility: SlackResponseVisibility,
         text: String) {
        
        self.responseVisibility = responseVisibility
        self.text = text
    }
}