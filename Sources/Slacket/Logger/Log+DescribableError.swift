//
//  Log+DescribableError.swift
//  Slacket
//
//  Created by Bartłomiej Nowak on 12/07/16.
//
//

import Foundation
import LoggerAPI

extension Log {
    
    static func debug(_ errorType: DescribableError) {
        debug(errorType.description)
    }
    
    static func error(_ errorType: DescribableError) {
        error(errorType.description)
    }
}