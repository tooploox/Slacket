//
//  PocketItemParser.swift
//  Slacket
//
//  Created by Jakub Tomanik on 30/05/16.
//
//

import Foundation
import Kitura
import SwiftyJSON
import LoggerAPI

struct PocketItemParser: ParserDecoderType {
    
    typealias Parsable = PocketItemType
    typealias ParsedType = JsonType
    
    static func decode(raw: ParsedType) -> Parsable? {
        if let itemId = raw["item_id"].string,
            let normalUrl = raw["normal_url"].URL,
            let resolvedId = raw["resolved_id"].string,
            let resolvedUrl = raw["resolved_url"].URL,
            let domainId = raw["domain_id"].string,
            let originDomainId = raw["origin_domain_id"].string,
            let responseCode = Int(raw["response_code"].string ?? ""),
            let mimeType = raw["mime_type"].string,
            let contentLength = Int(raw["content_length"].string ?? ""),
            let encoding = raw["encoding"].string,
            let dateResolved = raw["date_resolved"].string,
            let datePublished = raw["date_published"].string,
            let title = raw["title"].string,
            let excerpt = raw["excerpt"].string,
            let wordCount = Int(raw["word_count"].string ?? ""),
            let hasImage = Int(raw["has_image"].string ?? ""),
            let hasVideo = Int(raw["has_video"].string ?? ""),
            let isIndex = Int(raw["is_index"].string ?? ""),
            let isArticle = Int(raw["is_article"].string ?? "") {
            return PocketItem(itemId: itemId, normalUrl: normalUrl, resolvedId: resolvedId, resolvedUrl: resolvedUrl, domainId: domainId, originDomainId: originDomainId, responseCode: responseCode, mimeType: mimeType, contentLength: contentLength, encoding: encoding, dateResolved: dateResolved, datePublished: datePublished, title: title, excerpt: excerpt, wordCount: wordCount, hasImage: hasImage, hasVideo: hasVideo, isIndex: isIndex, isArticle: isArticle)
        } else {
            Log.debug(ConnectorError.pocketItemParserCouldntDecode)
            return nil
        }
    }
}