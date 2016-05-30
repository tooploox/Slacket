//
//  PPocketAuthorizationResponseService.swift
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

struct PocketAuthorizationResponseService: APIServiceType {
    
    static let errorDomain = "PocketAuthorizationResponseService"
    static let endpoint: APIServiceEndpointType = PocketAuthorizationEndpoint.Respond
    
    func handle(request: RouterRequest, response: RouterResponse, next: () -> Void) {
        Log.debug("\(self.dynamicType.errorDomain) handler")
        
        guard let slackId = request.params["slack_id"],
            let authorizationData = PocketAuthorizationDataStore.sharedInstance.getAuthData(slackId: slackId) else {
                let errorMessage = "Parameters not found"
                Log.error(errorMessage)
                response.error = self.getError(message: errorMessage)
                next()
                return
        }
        
        let requestData = PocketAccessTokenRequest(pocketRequestToken: authorizationData.requestToken)
        PocketAPIClient.RequestAccessToken(requestData).request() { error, status, headers, data in
            guard let status = status else {
                fatalError()
            }
            
            if let data = data where 200...299 ~= status,
                let parsedBody = BodyParser.parse(data, contentType: PocketAPIClient.RequestAccessToken(requestData).acceptContentType),
                let accessTokenResponse = PocketAccessTokenResponseParser.parse(body: parsedBody) {
                
                let accessTokenResponse = accessTokenResponse as PocketAccessTokenResponseType
                let slacketUserData = SlacketUser(slackId: slackId,
                                                  pocketAccessToken: accessTokenResponse.pocketAccessToken,
                                                  pocketUsername: accessTokenResponse.pocketUsername)

                SlacketUserDataStore.sharedInstance.setUserData(data: slacketUserData)
                next()
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