// See: https://getpocket.com/developer/docs/v3/add

struct PocketRequest {
    
    let url: String
    let consumerKey: String
    let accessToken: String
    let title: String?
    let tags: String? // Comma-separated list of tags to apply to the item
    let tweetid: String?
}