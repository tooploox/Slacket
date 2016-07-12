//
//  ErrorView.swift
//  Slacket
//
//  Created by Jakub Tomanik on 23/06/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

protocol ErrorViewResponder {

    func error(message: String?)
}

struct ErrorView: ErrorViewResponder {

    let response: RouterResponse

    func error(message: String?) {
        do {
            let _ = try response.send(status: .internalServerError)
        }
        catch {
            Log.error(ViewError.responseSendFailure(for: error))
        }
    }
}