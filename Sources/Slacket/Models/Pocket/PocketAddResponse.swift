//
//  PocketAddResponse.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

// https://getpocket.com/developer/docs/v3/add

protocol PocketAddResponseType: class {
    var item: PocketItemType { get }
    var status: Int { get }
}

class PocketAddResponse: PocketAddResponseType {
    let item: PocketItemType
    let status: Int

    init(item: PocketItemType,
         status: Int) {
        
        self.item = item
        self.status = status
    }
}