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

    func get(keyId: Storable.Identifier) -> Storable?
    func set(data: Storable) -> Bool
    func clear(keyId: Storable.Identifier) -> Bool
}