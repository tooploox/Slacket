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
import LoggerAPI

extension SlacketUser: StorableType {

    var keyId: String {
        return self.slackId
    }
}

extension SlacketUser: RedisStorableType {

    static func deserialize(redisObject: RespObject) -> SlacketUser? {
        Log.debug("SlacketUser deserialize")
        guard let serialized = try? redisObject.toString(),
            let data = serialized.data(using: NSUTF8StringEncoding),
            let urlEncoded = ParsedBody.init(data: data, contentType: "application/x-www-form-urlencoded") else {
                Log.debug(SlacketError.slacketUserDeserialization)
                return nil
        }
        Log.debug("deserialize ok")
        return SlacketUserParser.parse(body: urlEncoded) as? SlacketUser
    }

    func serialize() -> String? {
        Log.debug("SlacketUser serialize")
        guard let dictonary = SlacketUserParser.encode(model: self) else {
            Log.debug(SlacketError.slacketUserSerialization)
            return nil
        }
        let urlEncoded = ParsedBody.urlEncoded(dictonary as DictionaryType)
        if let data = urlEncoded.data,
        let string = String.init(data: data, encoding: NSUTF8StringEncoding) {
            Log.debug("deserialize ok")
            return string
        } else {
            Log.debug(SlacketError.slacketUserSerialization)
            return nil
        }
    }
}

class SlacketUserDataStore: RedisStoreProvider {

    typealias Storable = SlacketUser

    static let sharedInstance = SlacketUserDataStore()
}