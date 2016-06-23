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

protocol AuthorizeViewResponder {
    
    func show(message: String)
}

struct AuthorizeView: ParsedBodyResponder {
    
    let response: RouterResponse
    
    func show(message: String) {
        //self.show(body: ParsedBody.text(message))
        let filename = "auth.html"
        let publicDirectory = repoDirectory+"public/"
        let filePath = publicDirectory+filename
        let fileManager = NSFileManager()
        var isDirectory = ObjCBool(false)

        do {
            if fileManager.fileExists(atPath: filePath, isDirectory: &isDirectory) {
                //let contentType = ContentType.sharedInstance.getContentType(forFileName: filePath)
                try response.send(fileName: filePath)
            } else {
                try response.send(status: .internalServerError)
            }
        }
        catch {
            Log.error("Failed to send response \(error)")
        }
    }
}