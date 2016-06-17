//
//  PocketAddService.swift
//  Slacket
//
//  Created by Jakub Tomanik on 24/05/16.
//
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI
import SimpleHttpClient

protocol PocketConnectorType {
    
    static func addLink(url: String, tags: [String]?, user: SlacketUserType, completion: (PocketItemType?) -> Void )
}

struct PocketApiConnector: PocketConnectorType {
    
    static func addLink(url: String, tags: [String]?, user: SlacketUserType, completion: (PocketItemType?) -> Void) {
        guard let pocketAccessToken = user.pocketAccessToken else {
            completion(nil)
            return
        }
        
        let pocketAddRequest = PocketAddRequest(url: url,
                                                accessToken: pocketAccessToken,
                                                title: nil,
                                                tags: tags,
                                                tweetId: nil)
        let pocketEndpoint = PocketAPI.add(pocketAddRequest)
        pocketEndpoint.request() { error, status, headers, data in
            guard let status = status else {
                fatalError()
            }
            
            if let data = data where 200...299 ~= status,
            let pocketAddResponseBody = BodyParser.parse(data, contentType: pocketEndpoint.acceptContentType),
            let pocketAddResponse = PocketAddResponseParser.parse(body: pocketAddResponseBody) where pocketAddResponse.status == 1 {
                
                let pocketItem = pocketAddResponse.item
                completion(pocketItem)
            }
            completion(nil)
        }
    }
}