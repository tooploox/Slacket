//
//  DataStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 27/05/16.
//
//

import Foundation

protocol StoreType {}

protocol DataStore: StoreType {
    typealias Identifier = String
    associatedtype Storable
    
    func getData(id: Identifier) -> Storable?
    func setData(data: Storable) -> Identifier
}