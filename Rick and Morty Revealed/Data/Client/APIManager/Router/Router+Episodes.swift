// 
// Router+Episodes.swift
// Rick and Morty Revealed
// 

import Foundation

extension Route {
    static func episode(_ number: Int) -> Route {
        Route(
            path: "episode/\(number)",
            queryItems: nil
        )
    }
}
