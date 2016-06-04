//
//  SlacketUser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

protocol SlacketUserType {
    
    var slackId: String { get }
    var slackTeamId: String { get }
    var pocketAccessToken: String? { get }
    var pocketUsername: String? { get }
}

struct SlacketUser: SlacketUserType {
    
    let slackId: String
    let slackTeamId: String
    let pocketAccessToken: String?
    let pocketUsername: String?
}