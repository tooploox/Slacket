# Architecture
 
 Kitura Router : Router in (3,4) or Controller in (1)
 
 
 / Handlers     : Event Handlers, Middleware in Kitura, Presenter in (1,3,4)
 / Views        : Outputs results in a particular format (JSON, HTML, XML, etc)
 / Services     : Business Logic, Interactor in (1,3,4), Use Case in (2)
 / Adapters     : Interface Adapters in (2)
 / Gateways     : Entity Gateway in (1), Data Manager in (3)
    / Connectors    : Connect to external APIs
    / Stores        : Store data
 
 / Entities     : Entities in (1-4)
 / Modules : Ideally implements a single use case and consist same hierarchy as the app. App itself can be seen as a master-module. Module in (3,4)
 
 
 NOTE: Architecture was based on concepts from:
 (1) http://i.imgur.com/WkBAATy.png
 (2) https://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html
 (3) https://medium.com/brigade-engineering/brigades-experience-using-an-mvc-alternative-36ef1601a41f
 (4) https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52#.zf61xd1m7
 (5) https://www.objc.io/issues/13-architecture/viper/
