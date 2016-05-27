import Foundation

// https://getpocket.com/developer/docs/v3/add

protocol PocketAddItemType: class, SlacketModel {
    
    var url: String { get }
    var consumerKey: String { get }
    var accessToken: String { get }
    var title: String? { get }
    var tags: [String]? { get }
    var tweetId: String? { get }
}

class PocketAddItem: PocketAddItemType {
    
    let url: String
    let consumerKey: String
    let accessToken: String
    let title: String?
    let tags: [String]?
    let tweetId: String?
    
    init(url: String,
         consumerKey: String,
         accessToken: String,
         title: String? = nil,
         tags: [String]? = nil,
         tweetId: String? = nil) {
        
        self.url = url
        self.consumerKey = consumerKey
        self.accessToken = accessToken
        self.title = title
        self.tags = tags
        self.tweetId = tweetId
    }
}

protocol PocketAddResponseType: class, SlacketModel {
    var item: PocketItemType { get }
    var status: Int { get }
}

class PocketAddResponse: PocketAddResponseType {
    let item: PocketItemType
    let status: Int

    init(item: PocketItemType,
         status: Int) {
        
        self.item = item
        self.status = status
    }
}