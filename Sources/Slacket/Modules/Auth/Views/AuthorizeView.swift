//
//  SlacketView.swift
//  Slacket
//
//  Created by Jakub Tomanik on 02/06/16.
//
//

import Foundation
import Kitura
import KituraNet
import HeliumLogger
import LoggerAPI

import Mustache

enum AuthorizeMessage {
    case authorized
    case authorizationError
    case pocketError

    var filename: String {
        return "auth.mustache"
    }

    var context: [String: String] {
        var context = [
            "dir": "\(ExternalServerConfig().baseURL)",
            "title": "",
            "heading": "",
            "message": ""
        ]
        switch self {
            case .authorized:
                context["title"] = "Authorized"
                context["heading"] = "Hurrah :D"
                context["message"] = "Your Pocket account was linked to your Slack account.</br>Now you can use Slacket."
            case .authorizationError:
                context["title"] = "Not authorized"
                context["heading"] = "Bummer ;("
                context["message"] = SlacketError.pocketAuthorization.description
            case .pocketError:
                context["title"] = "Error"
                context["heading"] = "Oops ..."
                context["message"] = SlacketError.pocketUnknown.description
        }
        return context
    }

    var status: HTTPStatusCode {
        switch self {
            case .authorized:
                return .OK
            case .authorizationError:
                return .forbidden
            case .pocketError:
                return .serviceUnavailable
        }
    }
}

protocol AuthorizeViewResponder {
    func show(message: AuthorizeMessage)
}

struct AuthorizeView: ParsedBodyResponder {

    let response: RouterResponse

    func show(message: AuthorizeMessage) {
        let filename = message.filename
        let publicDirectory = repoDirectory + "public/"
        let filePath = publicDirectory + filename
        if let templateData = NSData(contentsOfFile: filePath),
            let templateString = String(data: templateData, encoding: NSUTF8StringEncoding),
            let template = try? Template(string: templateString),
            let body = try? template.render(context: Context(box: Box(dictionary: message.context))) {
            Log.debug("sending webpage: \(filePath)")
            response.status(message.status).send(body.string)
        } else {
            Log.error(ViewError.templateParsingFailure)
        }
    }
}