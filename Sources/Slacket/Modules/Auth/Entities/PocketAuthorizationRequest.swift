//
//  PocketAuthorizationRequest.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

// https://getpocket.com/developer/docs/authentication

protocol PocketAuthorizationRequestType: PocketAppType {
    
    var pocketRedirectUri : String { get }
}

struct PocketAuthorizationRequest: PocketAuthorizationRequestType {
    
    let pocketRedirectUri: String
}