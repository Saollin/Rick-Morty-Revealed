// 
// Environment.swift
// Rick and Morty Revealed
// 

import Foundation

enum Environment {
    enum ConfigKeys {
        static let apiURL = "API_URL"
        static let apiBasePath = "API_BASE_PATH"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let info = Bundle.main.infoDictionary else {
            fatalError("Info.plist file not found")
        }
        return info
    }()
    
    static let apiURL: URL = {
        guard let urlString = infoDictionary[ConfigKeys.apiURL] as? String else {
            fatalError("API URL not found in Info.plist file")
        }
        guard let url = URL(string: urlString) else {
            fatalError("API URL not valid")
        }
        return url
    }()
    
    static let apiBasePath: String = {
        guard let basePath = infoDictionary[ConfigKeys.apiBasePath] as? String else {
            fatalError("API BASE PATH not found in Info.plist file")
        }
        return basePath
    }()
}
