import Foundation

// https://api.slack.com/docs/formatting

protocol SlackResponseType: class, SlacketModel {}

// See: https://api.slack.com/slash-commands

enum SlackResponseType {
    case Ephemeral // Visible only to user that issued the command
    case InChannel // Visible to all members of the channel in which user typed the command
}

struct SlackResponse: SlackResponseType {

    let responseType: SlackCommandResponseType
    let text: String
    
    init(responseType: SlackCommandResponseType,
         text: String? = nil) {
        
        self.responseType = responseType
        self.text = text
    }
}