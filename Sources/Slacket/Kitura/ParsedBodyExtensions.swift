//
//  ParsedBodyExtensions.swift
//  Slacket
//
//  Created by Jakub Tomanik on 04/06/16.
//
//

import Foundation
import Kitura

extension ParsedBody {
    
    func isSameTypeAs(other: ParsedBody) -> Bool {
        
        switch (self, other) {
        case (.json, .json):
            return true
        case (.text, .text):
            return true
        case (.urlEncoded, .urlEncoded):
            return true
        default:
            return false
        }
    }
}