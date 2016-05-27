//
//  SlacketUserStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 27/05/16.
//
//

import Foundation

protocol SlacketUserProvider: DataStoreProvider {
    
    func getUser(slackId id: Identifier) -> Storable?
    func setUser(user: Storable) -> Identifier?
}

class SlacketUserStore: SlacketUserProvider {
    
    func setData(data: SlacketUser) -> String? {
        return nil
    }
    
    func setUser(user: SlacketUser) -> String? {
        return nil
    }
    
    func getData(id: String) -> SlacketUser? {
        return nil
    }
    
    func getUser(slackId id: String) -> SlacketUser? {
        return nil
    }
}