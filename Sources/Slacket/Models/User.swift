import Foundation

protocol SlacketUserType: SlacketModel {
    
    var slackId: String { get }
    var pocketAccessToken: String { get }
}