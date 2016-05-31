//
//  Architecture.swift
//  Slacket
//
//  Created by Jakub Tomanik on 31/05/16.
//
//

import Foundation

/*
 
 - Kitura Router : Router in (3,4) or Controller in (1)
 
 / Entities : Entities in (1-4)
 / Gateways : Entity Gateway in (1), Data Manager in (3)
    / Connectors : Connect to external APIs
    / Stores : Store data
 / Adapters : Interface Adapters in (2)
 / Handlers : Event Handlers, Middleware in Kitura, Presenter in (1,3,4)
 / Services : Business Logic, Interactor in (1,3,4), Use Case in (2)
 
 / Modules : Ideally implements a single use case and consist same hierarchy as the app. App itself can be seen as a master-module. Module in (3,4)
 
 NOTE: Architecture was based on concepts from:
 (1) http://i.imgur.com/WkBAATy.png
 (2) https://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html
 (3) https://medium.com/brigade-engineering/brigades-experience-using-an-mvc-alternative-36ef1601a41f
 (4) https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52#.zf61xd1m7
 */