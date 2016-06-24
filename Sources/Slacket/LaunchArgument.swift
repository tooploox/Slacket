//
//  LaunchArgument.swift
//  Slacket
//
//  Created by Jeremi Kaczmarczyk on 24.06.2016.
//
//

import Foundation

enum LaunchArgument: String {
    case OnLocalhost = "-l"
}

struct LaunchArgumentsProcessor {
    
    static var onLocalHost: Bool {
        return Process.arguments.flatMap { LaunchArgument(rawValue: $0) }.contains(.OnLocalhost)
    }
}