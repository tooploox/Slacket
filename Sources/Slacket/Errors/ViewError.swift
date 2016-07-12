//
//  ViewError.swift
//  Slacket
//
//  Created by Bartłomiej Nowak on 12/07/16.
//
//

import Foundation
import KituraNet

enum ViewError: ErrorProtocol, DescribableError {
    case responseSendFailure(for: ErrorProtocol)
    case messageParsingFailure
    case templateParsingFailure
    
    var description: String {
        switch self {
            case responseSendFailure(let error):
                return "Failed to send response with \(error)"
            case .messageParsingFailure:
                return "Failed parsing message"
            case .templateParsingFailure:
                return "Failed parsing template"
        }
    }
}