//
//  InMemoryStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 07/07/16.
//
//

import Foundation

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

    func clear(keyId: Storable.Identifier) -> Bool {
        let object = self.memoryStore.removeValue(forKey: keyId)
        return object != nil
    }
}