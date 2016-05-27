//
//  BackendService.swift
//  Slacket
//
//  Created by Jakub Tomanik on 20/05/16.
//
//

import Foundation

protocol BackendService {
    
    // This one will be used as a part of URL ./api/v1/:service_name/
    var name: String { get }
}