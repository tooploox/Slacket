// See: https://api.slack.com/methods/users.list

struct User {
    
    let id: String
    let name: String
    let color: String
    let profile: UserProfile
    let deleted: Bool
    let isAdmin: Bool
    let isOwner: Bool
    let has2fa: Bool
    let hasFiles: Bool
}