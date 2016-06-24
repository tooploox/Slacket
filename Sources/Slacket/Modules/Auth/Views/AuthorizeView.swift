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

}

protocol AuthorizeViewResponder {

    func show(message: AuthorizeMessage)
}

struct AuthorizeView: ParsedBodyResponder {

    let response: RouterResponse

    func show(message: AuthorizeMessage) {
        //self.show(body: ParsedBody.text(message))
        let filename = message.filename
        let publicDirectory = repoDirectory+"public/"
        let filePath = publicDirectory+filename
        let fileManager = NSFileManager()
        var isDirectory = ObjCBool(false)

        do {
            if fileManager.fileExists(atPath: filePath, isDirectory: &isDirectory) {
                //let contentType = ContentType.sharedInstance.getContentType(forFileName: filePath)
                Log.debug("responding with file: \(filePath)")
                try response.send(fileName: filePath)
            } else {
                Log.error("Could not find file: \(filePath)")
                try response.send(status: .internalServerError)
            }
        }
        catch {
            Log.error("Failed to send response \(error)")
        }
    }
}