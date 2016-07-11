//
//  RedisStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 07/07/16.
//
//

import Foundation
import Environment
import Redbird
import LoggerAPI

protocol RedisClientType {

    var host: String { get }
    var port: UInt16 { get }
}

extension RedisClientType {

    var host: String {
        guard let host = Environment().getVar("REDIS_HOST") else {
            fatalError("Cannot find REDIS_HOST environmental variable.")
        }
        return host
    }

    var port: UInt16 {
        return 6379
    }
}

protocol RedisStorableType: StorableType {

    static func deserialize(redisObject: RespObject) -> Self?
    func serialize() -> String?
}

protocol RedisStoreProvider: class, DataStoreProvider {

    var redisStore: RedisStore { get }
}

extension RedisStoreProvider where Storable: RedisStorableType, Storable.Identifier == String {

    var redisStore: RedisStore {
        return RedisStore.sharedInstance
    }

    func get(keyId: Storable.Identifier) -> Storable? {
        if let client = self.redisStore.client,
            let object = try? client.command("GET", params: [keyId]),
            let storable = Storable.deserialize(redisObject: object) {
            Log.debug("Redis GET for key: \(keyId)")
            return storable
        } else {
            Log.error("RedisStoreProvider error for GET")
            return nil
        }
    }

    func set(data: Storable) -> Bool {
        if let client = self.redisStore.client,
            let serialized = data.serialize(),
            let result = try? client.command("SET", params: [data.keyId, serialized]).toString() {
            Log.debug("Redis SET for key: \(data.keyId)")
            return result == "OK"
        } else {
            Log.error("RedisStoreProvider error for SET")
            return false
        }
    }

    func clear(keyId: Storable.Identifier) -> Bool {
        if let client = self.redisStore.client,
            let result = try? client.command("DEL", params: [keyId]).toInt() {
            Log.debug("Redis DEL for key: \(keyId)")
            return result > 0
        } else {
            Log.error("RedisStoreProvider error for DEL")
            return false
        }
    }
}

class RedisStore: RedisClientType {

    static let sharedInstance = RedisStore()

    lazy var client: Redbird? = {
        let config = RedbirdConfig(address: self.host, port: self.port)
        let client = try? Redbird(config: config)
        let logmessage = client != nil ? "OK" : "Error"
        Log.debug("Redis connection: \(logmessage)")
        return client
    }()
}