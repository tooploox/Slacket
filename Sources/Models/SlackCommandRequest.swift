// See: https://api.slack.com/slash-commands

struct SlackCommandRequest {
    
    let token: String
    let teamId: String
    let teamDomain: String
    let channelId: String
    let channelName: String
    let userId: String
    let userName: String
    let command: Command
    let responseUrl: String
    
    init(token: String, teamId: String, teamDomain: String, channelId: String, channelName: String, userId: String, userName: String, command: String, text: String, responseUrl: String) {
        self.token = token
        self.teamId = teamId
        self.teamDomain = teamDomain
        self.channelId = channelId
        self.channelName = channelName
        self.userId = userId
        self.userName = userName
        self.command = Command(name: command, parametersString: text)
        self.responseUrl = responseUrl
    }
}