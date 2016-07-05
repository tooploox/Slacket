//
//  ParserType.swift
//  Slacket
//
//  Created by Jakub Tomanik on 20/05/16.
//
//

import Foundation
import Kitura
import SwiftyJSON

typealias JsonType = JSON
typealias DictionaryType = [String: String]
typealias TextType = String

protocol ParserType {
    
    associatedtype Parsable
    associatedtype ParsedType
}