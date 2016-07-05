//
//  Service.swift
//  Slacket
//
//  Created by Jakub Tomanik on 31/05/16.
//
//

import Foundation

protocol Service {}

/*
 
 Service responsibilities:
 
 * Perform business logic
 
 The Service is what performs the business logic of the app that revolves around data.
 Service itself does not deal with network requests directly. In fact, it doesn’t even know that network requests are occurring. 
 All it knows is that it can get data in the form of entities from the Gateway
 
 */