//
//  SlacketView.swift
//  Slacket
//
//  Created by Jakub Tomanik on 02/06/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

import Mustache
import File

enum AuthorizeMessage {
    case authorized
    case authorizationError
    case pocketError

    var filename: String {
        switch self {
        case .authorized: return "auth.html"
        case .authorizationError: return "autherror.html"
        case .pocketError: return "pocketerror.html"
        }
    }

    var context: [String: String] {
        return [String: String]()
    }

}

protocol AuthorizeViewResponder {

    func show(message: AuthorizeMessage)
}

struct AuthorizeView: ParsedBodyResponder {

    let response: RouterResponse

    func show(message: AuthorizeMessage) {
        //
        let filename = message.filename
        let publicDirectory = repoDirectory+"public/"
        let filePath = publicDirectory+filename

        if let templateFile = try? File(path: filePath),
        let templateString = try? String(data: templateFile.readAllBytes()),
        let template = try? Template(string: templateString),
        let body = try? template.render(context: Context(box: Box(dictionary: message.context))) {
            do {
                Log.debug("sending webpage: \(filePath)")
                //response.headers.append("Content-Type", value: body.contentType)
                try response.send(body.string)
            }
            catch {
                Log.error("Failed to send response \(error)")
            }
        } else {
            Log.error("Failed to parse template")
        }
    }
}