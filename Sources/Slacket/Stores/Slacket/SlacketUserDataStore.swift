//
//  SlacketUserDataStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 25/05/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

protocol SlacketUserDataProvider: InMemoryStoreProvider {
    
    func getUserData(slackId id: Identifier) -> Storable?
    func setUserData(data: Storable) -> Identifier?
}

class SlacketUserDataStore: SlacketUserDataProvider {
    
    typealias Identifier = String
    typealias Storable = SlacketUserType
    
    static let sharedInstance = SlacketUserDataStore()
    
    var memoryStore: [Identifier: Storable] = [:]
    
    func getUserData(slackId id: Identifier) -> Storable? {
        return self.getData(id: id)
    }
    
    func setUserData(data: Storable) -> Identifier? {
        return self.setData(data: data, id: data.slackId)
    }
}