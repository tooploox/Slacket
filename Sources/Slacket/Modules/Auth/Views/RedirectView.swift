//
//  RedirectView.swift
//  Slacket
//
//  Created by Jakub Tomanik on 03/06/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

protocol RedirectResponder {
    
    var response: RouterResponse { get }
    
    init(response: RouterResponse)
    
    func redirect(to url: String)
}

struct RedirectView: RedirectResponder {
    
    let response: RouterResponse
    
    func redirect(to url: String) {
        do {
            Log.debug("redirecting to: \(url)")
            try response.redirect(url)
        }
        catch {
            Log.error(ViewError.responseSendFailure(for: error))
        }
    }
}