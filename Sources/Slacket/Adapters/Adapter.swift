//
//  Parser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 31/05/16.
//
//

import Foundation

protocol Adapter {}

/*

 Adapter responsibilities:
 
 * Convert data between different representations
 
 
 Adapters that convert data from the format most convenient for the:
 
 * Handlers 
    ** Kitura Request -> Request Model
    ** Response Model -> Kitura Response
 * Gateways
    ** Connectors : Converting Requests and Responses of external APIs
    ** Stores : If storing ie. in database require serialization / deserialization
*/