//
//  SlackCommand.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

// https://api.slack.com/slash-commands

protocol SlackCommandType {
    
    var token: String { get }
    var teamId: String { get }
    var teamDomain: String { get }
    var channelId: String { get }
    var channelName: String { get }
    var userId: String { get }
    var userName: String { get }
    var command: String { get }
    var text: String { get }
    var responseUrl: String { get }
}

struct SlackCommand: SlackCommandType {
    
    let token: String
    let teamId: String
    let teamDomain: String
    let channelId: String
    let channelName: String
    let userId: String
    let userName: String
    let command: String
    let text: String
    let responseUrl: String
}