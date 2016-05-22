// See: https://api.slack.com/slash-commands

enum SlackCommandResponseType {
    case Ephemeral // Visible only to user that issued the command
    case InChannel // Visible to all members of the channel in which user typed the command
}

struct SlackCommandResponse {
    
    // If you want the user to see their slash command displayed in the channel and
    // no response, generate a response with responseType = .InChannel and no text
    
    let responseType: SlackCommandResponseType
    let text: String?
    let attachments: [String: String]? // Used for further customisation of a message
    
    init(responseType: SlackCommandResponseType, text: String? = nil, attachments: [String: String]? = nil) {
        self.responseType = responseType
        self.text = text
        self.attachments = attachments
    }
}