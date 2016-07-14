//
//  PocketAddRequest.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

// https://getpocket.com/developer/docs/v3/add

protocol PocketAddRequestType: class, PocketAppType {
    
    var pocketAccessToken: String { get }
    
    var url: String { get }
    var title: String? { get }
    var tags: [String]? { get }
    var tweetId: String? { get }
}

class PocketAddRequest: PocketAddRequestType {
    
    let url: String
    let pocketAccessToken: String
    let title: String?
    let tags: [String]?
    let tweetId: String?
    
    init(url: String,
         accessToken: String,
         title: String? = nil,
         tags: [String]? = nil,
         tweetId: String? = nil) {
        
        self.url = url
        self.pocketAccessToken = accessToken
        self.title = title
        self.tags = tags
        self.tweetId = tweetId
    }
}