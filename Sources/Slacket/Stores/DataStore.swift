//
//  DataStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 27/05/16.
//
//

import Foundation

protocol StoreType {
    
    
}

protocol DataStoreProvider: StoreType {
    
    associatedtype Identifier
    associatedtype Storable
    
    func getData(id: Identifier) -> Storable?
    func setData(data: Storable) -> Identifier?
}