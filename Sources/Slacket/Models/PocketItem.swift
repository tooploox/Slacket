import Foundation

// https://getpocket.com/developer/docs/v3/add

protocol PocketItemType: class, SlacketModel {
    
    var itemId: String         // A unique identifier for the added item
    var normalUrl: NSURL        // The original url for the added item
    var resolvedId: String      // A unique identifier for the resolved item
    var resolvedUrl: NSURL      // The resolved url for the added item. The easiest way to think about the resolved_url - if you add a bit.ly link, the resolved_url will be the url of the page the bit.ly link points to
    var domainId: String        // A unique identifier for the domain of the resolved_url
    var originDomainId: String  // A unique identifier for the domain of the normal_url
    var responseCode: Int       // The response code received by the Pocket parser when it tried to access the item
    var mimeType: String        // The MIME type returned by the item
    var contentLength: Int      // The content length of the item
    var encoding: String        // The encoding of the item
    var dateResolved: NSDate    // The date the item was resolved
    var datePublished: NSDate?  // The date the item was published (if the parser was able to find one)
    var title: String           // The title of the resolved_url
    var excerpt: String?        // The excerpt of the resolved_url
    var wordCount: Int?         // For an article, the number of words
    var hasImage: Int           // 0: no image; 1: has an image in the body of the article; 2: is an image
    var hasVideo: Int           // 0: no video; 1: has a video in the body of the article; 2: is a video
    var isIndex: Int            // 0 or 1; If the parser thinks this item is an index page it will be set to 1
    var isArticle: Int          // 0 or 1; If the parser thinks this item is an article it will be set to 1
}

class PocketItem: PocketItemType {
    
    let itemId: String
    let normalUrl: NSURL
    let resolvedId: String
    let resolvedUrl: NSURL
    let domainId: String
    let originDomainId: String
    let responseCode: Int
    let mimeType: String
    let contentLength: Int
    let encoding: String
    let dateResolved: NSDate
    let datePublished: NSDate?
    let title: String
    let excerpt: String?
    let wordCount: Int?
    let hasImage: Int
    let hasVideo: Int
    let isIndex: Int
    let isArticle: Int
    
    init(itemId: String,
         normalUrl: NSURL,
         resolvedId: String,
         resolvedUrl: NSURL,
         domainId: String,
         originDomainId: String,
         responseCode: Int,
         mimeType: String,
         contentLength: Int,
         encoding: String,
         dateResolved: NSDate,
         datePublished: NSDate?,
         title: String,
         excerpt: String?,
         wordCount: Int?,
         hasImage: Int,
         hasVideo: Int,
         isIndex: Int,
         isArticle: Int) {
        
        self.itemId = item_id
        self.normalUrl = normalUrl
        self.resolvedId = resolvedId
        self.resolvedUrl = resolvedUrl
        self.domainId = domainId
        self.originDomainId = originDomainId
        self.responseCode = responseCode
        self.mimeType = mimeType
        self.contentLength = contentLength
        self.encoding = encoding
        self.dateResolved = dateResolved
        self.datePublished = datePublished
        self.title = title
        self.excerpt = excerpt
        self.wordCount = wordCount
        self.hasImage = hasImage
        self.hasVideo = hasVideo
        self.isIndex = isIndex
        self.isArticle = isArticle
    }
}

