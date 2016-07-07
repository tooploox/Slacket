//
//  InMemoryStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 07/07/16.
//
//

import Foundation

protocol InMemoryStoreProvider: class, DataStoreProvider {

    var store: [Storable.Identifier: Storable] { get set }
}

extension InMemoryStoreProvider {

    func get(keyId: Storable.Identifier) -> Storable? {
        return self.store[keyId]
    }

    func set(data: Storable) -> Bool {
        self.store[data.keyId] = data
        return true
    }

    func clear(keyId: Storable.Identifier) -> Storable? {
        return self.store.removeValue(forKey: keyId)
    }
}