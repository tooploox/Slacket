//
//  PocketAddRequest.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

// https://getpocket.com/developer/docs/v3/add

protocol PocketAddRequestType: class, SlacketModel, PocketAppType {
    
    var pocketAccessToken: String { get }
    
    var url: String { get }
    var title: String? { get }
    var tags: [String]? { get }
    var tweetId: String? { get }
}

extension PocketAddRequestType {
    
    var decodedURL: String {
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            let decodedUrl = url.stringByRemovingPercentEncoding
        #else
            let decodedUrl = url.removingPercentEncoding
        #endif
        
        guard let url = decodedUrl else {
            fatalError("URL decodaing failed")
        }
        return url
    }
    
    var tagsString: String {
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            let tags = self.tags?.componentsJoinedByString(",")
        #else
            let tags = self.tags?.joined(separator: ",")
        #endif
        return tags ?? ""
    }
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