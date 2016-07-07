//
//  SlacketUserDataStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 25/05/16.
//
//

import Foundation

extension SlacketUser: StorableType {
    
    var keyId: String {
        return self.slackId
    }
}

class SlacketUserDataStore: InMemoryStoreProvider {
    
    typealias Storable = SlacketUser
    
    static let sharedInstance = SlacketUserDataStore()
    
    var store: [Storable.Identifier: Storable] = [:]
}