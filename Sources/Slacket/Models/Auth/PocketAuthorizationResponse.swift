//
//  PocketAuthorizationResponse.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

// https://getpocket.com/developer/docs/authentication

protocol PocketAuthorizationResponseType {
    
    var pocketRequestToken: String { get }
}

struct PocketAuthorizationResponse: PocketAuthorizationResponseType {
    
    let pocketRequestToken: String
}