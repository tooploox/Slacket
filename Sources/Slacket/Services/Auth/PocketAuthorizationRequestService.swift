//
//  PocketAuthorizationRequestService.swift
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

struct PocketAuthorizationRequestService: APIServiceType {
    
    static let errorDomain = "PocketAuthorizationRequestService"
    static let endpoint: APIServiceEndpointType = PocketAuthorizationEndpoint.Request
    
    func handle(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        Log.debug("\(self.dynamicType.errorDomain) handler")
        
        guard let slackId = request.params["slack_id"] else {
            let errorMessage = "Parameters not found"
            Log.error(errorMessage)
            response.error = self.getError(message: errorMessage)
            next()
            return
        }
        
        let requestData = PocketAuthorizationRequest(pocketRedirectUri: PocketAuthorizationEndpoint.Respond.route)
        
        PocketAPI.RequestAuthorization(requestData).request() { error, status, headers, data in
            guard let status = status else {
                fatalError()
            }
            
            if let data = data where 200...299 ~= status,
                let parsedBody = BodyParser.parse(data, contentType: PocketAPI.RequestAuthorization(requestData).acceptContentType),
                let authorizationResponse = PocketAuthorizationResponseParser.parse(body: parsedBody) {
                
                let authorizationResponse = authorizationResponse as PocketAuthorizationResponseType
                let authorizationData = PocketAuthorizationData(id: slackId,
                                                                requestToken: authorizationResponse.pocketRequestToken)
                PocketAuthorizationDataStore.sharedInstance.set(data: authorizationData)
                let redirecTo = "\(PocketAuthorizationEndpoint.Respond.directToUrl(id: slackId))"
                
                do { try response.redirect(redirecTo) }
                catch {}
                return
                
            } else if let _ = error {
                let errorMessage = "Pocket API returned error"
                Log.error(errorMessage)
                response.error = self.getError(message: errorMessage)
                next()
                return
            }
            
            next()
            return
        }
    }
}