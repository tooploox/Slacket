//
//  PocketService.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation
import Kitura
import SimpleHttpClient

protocol PocketAppType {
    
    var pocketConsumerKey: String { get }
}

extension PocketAppType {
    
    var pocketConsumerKey: String {
        return "54643-3989062fcc074d7073bfcc5f"
    }
}