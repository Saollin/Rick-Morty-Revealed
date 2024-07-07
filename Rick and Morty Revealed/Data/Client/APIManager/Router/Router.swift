// 
// Router.swift
// Rick and Morty Revealed
// 

import Foundation

struct Route {
    let path: String
    let queryItems: [URLQueryItem]?
    
    var url: URL {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = Environment.apiURL.absoluteString
        components.path = "/\(Environment.apiBasePath)/\(path)/"
        components.queryItems = queryItems
        
        return components.url!
    }
}

enum Router {}
