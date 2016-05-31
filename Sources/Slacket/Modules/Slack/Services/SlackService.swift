import Foundation

//protocol SlackService: BackendService {}

protocol SlackAppType {
    
    var slackToken: String { get }
}

extension SlackAppType {
    
    var slackToken: String {
        return "SJ0sPVUmpujXy52BIK8NV7nn"
    }
}