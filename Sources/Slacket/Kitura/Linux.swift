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
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            return self.hasPrefix(prefix)
        #else
            return self.hasPrefix(prefix)
        #endif
    }
    
    func trimWhitespace() -> String {
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            return self.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " "))
        #else
            return self.trimmingCharacters(in: NSCharacterSet(charactersIn: " "))
        #endif
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
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            return self.dataUsingEncoding(NSUTF8StringEncoding)
        #else
            return self.data(using: NSUTF8StringEncoding)
        #endif
    }
    
    func replaceOccurrences(of: String, with: String) -> String {
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            return self.stringByReplacingOccurrencesOfString(of, withString: with)
        #else
            return self.replacingOccurrences(of: of, with: with)
        #endif

    }
    
    func separatedComponents(separatedBy separator: String) -> [String] {
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/blob/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation/String.swift
            return self.componentsSeparatedByString(separator)
        #else
            return self.components(separatedBy: separator)
        #endif
    }
    
    func stringByAddingPercentEncoding() -> String? {
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/blob/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation/NSURL.swift
            return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumerics().mutableCopy().addCharacters(in: "_"))
        #else
            let characterSet = NSMutableCharacterSet()
            characterSet.formUnion(with: NSCharacterSet.alphanumerics())
            characterSet.addCharacters(in: "_")
            return self.addingPercentEncoding(withAllowedCharacters: characterSet)
        #endif
    }
}

extension NSData: SocketReader {
    
    public func readString() throws -> String? {
        
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            return String(data: self, encoding: NSUTF8StringEncoding)
        #else
            return String(data: self, encoding: NSUTF8StringEncoding)
        #endif
    }
    
    public func read(into data: NSMutableData) throws -> Int {
        
        #if os(Linux)
            // from https://github.com/apple/swift-corelibs-foundation/tree/d2dc9f3cf91100b752476a72c519a8a629d9df2c/Foundation
            return try self.read(into: data)
        #else
            return try self.read(into: data)
        #endif
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