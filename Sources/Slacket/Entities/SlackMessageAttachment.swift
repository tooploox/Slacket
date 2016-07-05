//
//  SlackMessage.swift
//  Slacket
//
//  Created by Jakub Tomanik on 29/05/16.
//
//

import Foundation

// https://api.slack.com/docs/formatting

protocol SlackMessageAttachmentFieldType {
    
    var title: String { get }       // "title" Priority
    var value: String { get }       // "value" High
    var short: Bool { get }         // "short" false
}

protocol SlackMessageAttachmentAuthorType {
    
    var authorName: String { get }  // "author_name" Bobby Tables
    var authorLink: String { get }  // "author_link" http://flickr.com/bobby/
    var authorIcon: String { get }  // "author_icon" http://flickr.com/icons/bobby.jpg
}

protocol SlackMessageAttachmentFooterType {
    
    var footer: String? { get }      // "footer" Slack API
    var footerIcon: String? { get }  // "footer_icon" https://platform.slack-edge.com/img/default_application_icon.png
    var timestamp: Int? { get }      // "ts" field with an integer value in "epoch time"
}

protocol SlackMessageAttachmentType {
    
    var fallback: String { get }    // "fallback" Required plain-text summary of the attachment.
    var color: String? { get }       // "color" #36a64f
    var pretext: String? { get }     // "pretext" Optional text that appears above the attachment block
    var title: String? { get }       // "title" Slack API Documentation
    var titleLink: String? { get }   // "title_link" https://api.slack.com/
    var text: String? { get }        // "text" Optional text that appears within the attachment
    var imageUrl: String? { get }    // "image_url" http://my-website.com/path/to/image.jpg
    var thumbUrl: String? { get }    // "thumb_url" http://example.com/path/to/thumb.png

    var footer: SlackMessageAttachmentFooterType? { get }
    var author: SlackMessageAttachmentAuthorType? { get }
    var fields: [SlackMessageAttachmentFieldType]? { get }
}

struct SlackMessageAttachment: SlackMessageAttachmentType {
    
    let fallback: String
    let color: String?
    let pretext: String?
    let title: String?
    let titleLink: String?
    let text: String?
    let imageUrl: String?
    let thumbUrl: String?
    
    let footer: SlackMessageAttachmentFooterType?
    let author: SlackMessageAttachmentAuthorType?
    let fields: [SlackMessageAttachmentFieldType]?
}