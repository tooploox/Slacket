//
//  APIClient.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation
import Kitura
import SimpleHttpClient
import LoggerAPI

struct ConnectorProvider<Endpoint: ConnectorEndpoint> {
    
    static func request(endpoint: Endpoint, completionHandler handler: NetworkRequestCompletionHandler) {
        switch endpoint.method {
        case .get:
            HttpClient.get(resource: endpoint.resource, headers: endpoint.headers, completionHandler: handler)
        case .post:
            HttpClient.post(resource: endpoint.resource, headers: endpoint.headers, data: endpoint.data, completionHandler: handler)
        default:
            Log.error("Unsupported endpoint.method case")
            fatalError()
        }
    }
}