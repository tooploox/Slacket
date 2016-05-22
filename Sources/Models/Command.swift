import Foundation

struct Command {
    
    let name: String
    let parameters: [String]
    
    init(name: String, parametersString: String) {
        self.name = name
        parameters = parametersString.components(separatedBy: " ")
    }
}