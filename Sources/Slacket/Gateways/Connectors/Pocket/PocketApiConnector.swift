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
            Log.error("pocketAccessToken is nil")
            return completion(nil)
        }
        
        let pocketAddRequest = PocketAddRequest(url: url,
                                                accessToken: pocketAccessToken,
                                                title: nil,
                                                tags: tags,
                                                tweetId: nil)
        let pocketEndpoint = PocketAPI.add(pocketAddRequest)
        pocketEndpoint.request() { error, status, headers, data in
            guard let status = status else {
                Log.error("status is nil")
                fatalError()
            }
            Log.debug("pocketEndpoint.request() returned status \(status)")
            Log.debug("pocketEndpoint.request() returned headers\n\(headers)")
            
            if let data = data where 200...299 ~= status,
                let pocketAddResponseBody = ParsedBody.init(data: data, contentType: pocketEndpoint.acceptContentType) {
                if let pocketAddResponse = PocketAddResponseParser.parse(body: pocketAddResponseBody)
                    where pocketAddResponse.status == 1 {
                    completion(pocketAddResponse.item)
                } else {
                    Log.debug("pocketAddResponse is nil or pocketAddResponse.status != 1")
                    completion(nil)
                }
            } else {
                Log.debug("data or pocketAddResponseBody is nil")
                completion(nil)
            }
        }
    }
}