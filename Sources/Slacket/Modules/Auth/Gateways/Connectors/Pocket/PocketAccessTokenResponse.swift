//
//  SlacketUser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

protocol PocketAccessTokenResponseType {
    
    var pocketAccessToken: String { get }
    var pocketUsername: String { get }
}

struct PocketAccessTokenResponse: PocketAccessTokenResponseType {
    
    let pocketAccessToken: String
    let pocketUsername: String
}