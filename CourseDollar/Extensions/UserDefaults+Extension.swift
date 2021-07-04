import Foundation


extension UserDefaults {
    enum Keys: String {
        case lastDateChange = "@lastDateChange"
    }
    
    static func getKey(_ key: UserDefaults.Keys) -> String {
        return key.rawValue
    }
}
