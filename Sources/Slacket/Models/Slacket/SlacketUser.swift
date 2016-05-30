//
//  SlacketUser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

protocol SlacketUserType: class, SlacketModel {
    
    var slackId: String { get }
    //var slackTeamId: String { get }
    var pocketAccessToken: String { get }
}

class SlacketUser: SlacketUserType {
    
    let slackId: String
    //let slackTeamId: String
    let pocketAccessToken: String
    let pocketUsername: String
    
    init(slackId: String,
         //slackTeamId: String,
         pocketAccessToken: String,
         pocketUsername: String) {
        
        self.slackId = slackId
        //self.slackTeamId = slackTeamId
        self.pocketAccessToken = pocketAccessToken
        self.pocketUsername = pocketUsername
    }
}