//
//  SlacketUserDataStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 25/05/16.
//
//

import Foundation
import Redbird
import Kitura

extension SlacketUser: StorableType {

    var keyId: String {
        return self.slackId
    }
}

extension SlacketUser: RedisStorableType {

    static func deserialize(redisObject: RespObject) -> SlacketUser? {
        guard let serialized = try? redisObject.toString() where redisObject.respType == .SimpleString,
            let data = serialized.data(using: NSUTF8StringEncoding),
            let urlEncoded = ParsedBody.init(data: data, contentType: "application/x-www-form-urlencoded") else {
                return nil
        }
        return SlacketUserParser.parse(body: urlEncoded) as? SlacketUser
    }

    func serialize() -> String? {
        guard let dictonary = SlacketUserParser.encode(model: self) else {
            return nil
        }
        let urlEncoded = ParsedBody.urlEncoded(dictonary as DictionaryType)
        if let data = urlEncoded.data,
        let string = String.init(data: data, encoding: NSUTF8StringEncoding) {
            return string
        } else {
            return nil
        }
    }
}

class SlacketUserDataStore: RedisStoreProvider {

    typealias Storable = SlacketUser

    static let sharedInstance = SlacketUserDataStore()
}