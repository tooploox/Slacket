//
//  Handler.swift
//  Slacket
//
//  Created by Jakub Tomanik on 31/05/16.
//
//

import Foundation

protocol Handler {}

/*
 
 Handler responsibilities:
 
 * Reacting to Router reqests and invoking appropirate Service with data it requires
 * Responding to Router with properly formated data
 
 Handlers shield rest of the app from web framework (Kitura)
 Handler mainly consists of logic to drive the View.
 Handler process input from user (requests) and invokes methods on the Service.
 
 */


/*
 
 RouterRequest -> Adapter -> RequestModel
 raw -> KituraAdapter -> HTTPRequestModel
 
 -------- clean boundry -------
 
 RequestModel -> Action
 RequestModel -> Adapter -> Entity
 
 Handler(Action) -> Service(Entity)
 Service -> Handler(Entity)
 
 Entity -> Adapter -> ResponseModel
 
 -------- clean boundry -------
 
 ResponseModel
 ResponseModel -> Adapter -> ViewModel
 Model -> ModelEncoder -> JSON
 
 ViewModel -> View -> RouterResponse
 JSON -> application/json -> raw
 
 */