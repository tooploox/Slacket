//
//  SlacketUser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

protocol PocketAccessTokenRequestType: PocketAppType {
    
    var pocketRequestToken: String { get }
}

struct PocketAccessTokenRequest: PocketAccessTokenRequestType {
    
    let pocketRequestToken: String
}