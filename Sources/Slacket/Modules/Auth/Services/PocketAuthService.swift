import Foundation

enum PocketAuthorizationEndpoint: APIServiceEndpointType {
    case Request
    case Respond
    
    var route: String {
        switch self {
        case .Request:
            return "api/v1/pocket/auth/request"
        case .Respond:
            return "api/v1/pocket/auth/respond"
        }
    }
    
    var requiredQueryParameters: [String]? {
        return ["slack_id"]
    }
    
    func directToUrl(id: String) -> String {
        return "\(self.schema.rawValue)://\(self.host)/\(self.route)?slack_id=\(id)"
    }
}