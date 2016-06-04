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
        case (.Json, .Json):
            return true
        case (.Text, .Text):
            return true
        case (.UrlEncoded, .UrlEncoded):
            return true
        default:
            return false
        }
    }
}