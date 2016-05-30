//
//  SlacketUserDataStore.swift
//  SampleServer
//
//  Created by Jakub Tomanik on 25/05/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

protocol PocketAuthorizationDataProvider: InMemoryStoreProvider {
    
    func getAuthData(slackId id: Identifier) -> Storable?
    func setAuthData(data: Storable) -> Identifier?
}

class PocketAuthorizationDataStore: PocketAuthorizationDataProvider {
    
    typealias Identifier = String
    typealias Storable = PocketAuthorizationDataType
    
    static let sharedInstance = PocketAuthorizationDataStore()
    
    var memoryStore: [Identifier: Storable] = [:]
    
    func getAuthData(slackId id: Identifier) -> Storable? {
        return self.getData(id: id)
    }
    
    func setAuthData(data: Storable) -> Identifier? {
        return self.setData(data: data, id: data.id)
    }
}