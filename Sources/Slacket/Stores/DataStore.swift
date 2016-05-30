//
//  DataStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 27/05/16.
//
//

import Foundation

protocol StoreType { }

protocol DataStoreProvider: StoreType {
    
    associatedtype Identifier : Hashable
    associatedtype Storable
    
    //func getData(id: Identifier) -> Storable?
    //func setData(data: Storable) -> Identifier?
}

protocol InMemoryStoreProvider: class, DataStoreProvider {
    
    var memoryStore: [Identifier: Storable] { get set }
}

extension InMemoryStoreProvider {

    func getData(id: Identifier) -> Storable? {
        guard let data = self.memoryStore[id] else {
            return nil
        }
        return data
    }
    
    func setData(data: Storable, id: Identifier) -> Identifier? {
        self.memoryStore[id] = data
        return id
    }
}