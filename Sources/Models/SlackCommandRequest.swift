struct SlackCommandRequest {
    
    let user_name: String
    let user_id: String
    let token: String
    let command: Command
    let response_url: String
}