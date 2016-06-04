//
//  APIServiceEndpoint.swift
//  Slacket
//
//  Created by Jakub Tomanik on 20/05/16.
//
//

import Foundation
import Kitura

protocol HandlerAction {
    
    var method: Kitura.RouterMethod { get }
    var route: String { get }
    var requiredParameters: [String]? { get}
    var requiredQueryParameters: [String]? { get }
    var requiredBodyType: ParsedBody? { get }
    
    init?(request: Kitura.RouterRequest)
    
    static func from(route: String) -> Self?
}

extension HandlerAction {
    
    var routerMethod: Kitura.RouterMethod { return .Get }
    var requiredParameters: [String]? { return nil }
    var requiredQueryParameters: [String]? { return nil }
    var requiredBodyType: ParsedBody? { return nil }
}

extension HandlerAction {
    
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

extension HandlerAction {
    
    init?(request: Kitura.RouterRequest) {
        guard let
            action = Self.from(route: request.matchedPath) where
            request.method == action.method &&
                action.hasAllRequiredParameters(request: request) else {
                    return nil
        }
        self = action
    }
}