//
//  RedisStore.swift
//  Slacket
//
//  Created by Jakub Tomanik on 07/07/16.
//
//

import Foundation
import Redbird

protocol RedisStoreProvider: class, DataStoreProvider {

    var store: Redbird { get }
}
