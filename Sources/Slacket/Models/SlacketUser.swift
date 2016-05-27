import Foundation

protocol SlacketUserType: class, SlacketModel {
    
    var slackId: String { get }
    var pocketAccessToken: String { get }
}

class SlacketUser: SlacketUserType {
    
    let slackId: String
    let pocketAccessToken: String
    let pocketUsername: String
    
    init(slackId: String,
         pocketAccessToken: String,
         pocketUsername: String) {
        
        self.slackId = slackId
        self.pocketAccessToken = pocketAccessToken
        self.pocketUsername = pocketUsername
    }
}