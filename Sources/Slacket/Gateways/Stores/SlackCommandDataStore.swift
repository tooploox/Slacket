//
//  SlackCommandDataStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation

extension SlackCommand: StorableType {

    var keyId: String {
        return self.responseUrl
    }
}

class SlackCommandDataStore: InMemoryStoreProvider {

    typealias Storable = SlackCommand

    static let sharedInstance = SlackCommandDataStore()

    var memoryStore: [Storable.Identifier: Storable] = [:]
}
