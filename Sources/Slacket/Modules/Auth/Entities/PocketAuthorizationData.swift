//
//  PocketAuthorizationData.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

// https://getpocket.com/developer/docs/authentication

protocol PocketAuthorizationDataType {
    
    var id: String { get }
    var requestToken: String { get }
}

struct PocketAuthorizationData: PocketAuthorizationDataType {
    
    let id: String
    let requestToken: String
}