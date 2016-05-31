//
//  SlacketUserDataStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 25/05/16.
//
//

import Foundation

extension PocketAuthorizationData: StorableType {
    
    var keyId: String {
        return self.id
    }
}

class PocketAuthorizationDataStore: InMemoryStoreProvider {

    typealias Storable = PocketAuthorizationData
    
    static let sharedInstance = PocketAuthorizationDataStore()
    
    var memoryStore: [Storable.Identifier: Storable] = [:]
}