//
//  APIServiceEndpoint.swift
//  Slacket
//
//  Created by Jakub Tomanik on 20/05/16.
//
//

import Foundation
import Kitura

protocol APIServiceEndpointType: APIService {
    
    var routerMethod: RouterMethod { get }
    var route: String { get }
    var requiredParameters: [String]? { get}
    var requiredQueryParameters: [String]? { get }
    var requiredBodyType: ParsedBody? { get }
}

extension APIServiceEndpointType {
    
    var routerMethod: RouterMethod {
        return .Get
    }
    
    var requiredParameters: [String]? {
        return nil
    }
    
    var requiredQueryParameters: [String]? {
        return nil
    }
    
    var requiredBodyType: ParsedBody? {
        return nil
    }
}

extension APIServiceEndpointType {
    
    func hasAllRequiredParameters(request: RouterRequest ) -> Bool {
        var result = true
        result = result && hasRequiredParameters(params: request.params)
        result = result && hasRequiredQueryParameters(params: request.queryParams)
        result = result && hasRequiredBodyType(body: request.body)
        return result
    }
    
    private func hasRequiredParameters(params: [String: String]) -> Bool {
        guard let prerequisites = self.requiredParameters else {
            return true
        }
        
        let check = prerequisites.flatMap { params[$0] }
        return check.count == prerequisites.count
    }
    
    private func hasRequiredQueryParameters(params: [String: String]) -> Bool {
        guard let prerequisites = self.requiredQueryParameters else {
            return true
        }
        
        let check = prerequisites.flatMap { params[$0] }
        return check.count == prerequisites.count
    }
    
    private func hasRequiredBodyType(body: ParsedBody?) -> Bool {
        guard let prerequisites = self.requiredBodyType else {
            return true
        }
        guard let body = body else {
            return false
        }
        
        return body.isSameTypeAs(other: prerequisites)
    }
}

private extension ParsedBody {
    
    func isSameTypeAs(other: ParsedBody) -> Bool {
        
        switch (self, other) {
        case (.Json, .Json):
            return true
        case (.Text, .Text):
            return true
        case (.UrlEncoded, .UrlEncoded):
            return true
        default:
            return false
        }
    }
}