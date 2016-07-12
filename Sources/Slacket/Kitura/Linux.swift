//
//  Linux.swift
//  Slacket
//
//  Created by Jakub Tomanik on 03/06/16.
//
//

import Foundation
import Socket

// Linux compability helpers, that should not be neccesery in Swift preview 1

extension Sequence where Iterator.Element == String {
    
    func joinedBy(separator: String) -> String {
        return self.joined(separator: separator)
    }
}

extension String {
    
    func startsWith(prefix: String) -> Bool {
        return self.hasPrefix(prefix)
    }

    func trimWhitespace() -> String {
        return self.trimmingCharacters(in: NSCharacterSet(charactersIn: " "))
    }

    func withoutPercentEncoding() -> String? {
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            return self.stringByRemovingPercentEncoding
        #else
            return self.removingPercentEncoding
        #endif
    }

    var encodedData: NSData? {
        return self.data(using: NSUTF8StringEncoding)
    }

    func replaceOccurrences(of: String, with: String) -> String {
        return self.replacingOccurrences(of: of, with: with)
    }

    func separatedComponents(separatedBy separator: String) -> [String] {
        return self.components(separatedBy: separator)
    }
    
    func stringByAddingPercentEncoding() -> String? {
        let characterSet = NSMutableCharacterSet(charactersIn: "_")
        characterSet.formUnion(with: NSCharacterSet.alphanumerics())
        #if os(Linux)
            return self.stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
        #else
            return self.addingPercentEncoding(withAllowedCharacters: characterSet)
        #endif
    }
}

extension NSData: SocketReader {
    public func readString() throws -> String? {
        return String(data: self, encoding: NSUTF8StringEncoding)
    }

    public func read(into data: NSMutableData) throws -> Int {
        return try self.read(into: data)
    }
}

extension Dictionary {
    func merge(dict: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
        var mutableCopy = self
        for (key, value) in dict {
            // If both dictionaries have a value for same key, the value of the other dictionary is used.
            mutableCopy[key] = value
        }
        return mutableCopy
    }
}