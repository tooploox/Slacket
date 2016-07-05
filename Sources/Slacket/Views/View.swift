//
//  View.swift
//  Slacket
//
//  Created by Jakub Tomanik on 31/05/16.
//
//

import Foundation
import Kitura

protocol ViewResponder {

    var response: RouterResponse { get }
    
    init(response: RouterResponse)
}

/*
 
 View responsibilities:
 
 * Output information to the user
 
 The view is told by the presenter what to display.
 View outputs to `RouterResponse` object
 View is responsible for returning information to the user (caller of the API) in appropirate format (JSON, XML, HTML, etc.)
 
*/