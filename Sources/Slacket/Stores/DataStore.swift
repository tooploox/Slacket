//
//  DataStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 27/05/16.
//
//

import Foundation

protocol StoreType { }

protocol StorableType {
    
    associatedtype Identifier : Hashable
    
    var keyId: Identifier { get }
}

protocol DataStoreProvider: StoreType {
    
    associatedtype Storable: StorableType
}

protocol InMemoryStoreProvider: class, DataStoreProvider {
    
    var memoryStore: [Storable.Identifier: Storable] { get set }
}

extension InMemoryStoreProvider {

    func get(keyId: Storable.Identifier) -> Storable? {
        return self.memoryStore[keyId]
    }
    
    func set(data: Storable) -> Bool {
        self.memoryStore[data.keyId] = data
        return true
    }
    
    func clear(keyId: Storable.Identifier) -> Storable? {
        return self.memoryStore.removeValue(forKey: keyId)
    }
}