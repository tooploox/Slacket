//
//  SlacketView.swift
//  Slacket
//
//  Created by Jakub Tomanik on 02/06/16.
//
//

import Foundation
import Kitura
import SwiftyJSON

protocol AuthorizeViewResponder {
    
    func show(message: String)
}

struct AuthorizeView: ParsedBodyResponder {
    
    let response: RouterResponse
    
    func show(message: String) {
        self.show(body: ParsedBody.text(message))
    }
}