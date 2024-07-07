// 
// Router+Episodes.swift
// Rick and Morty Revealed
// 

import Foundation

extension Route {
    static func episode(_ page: Int) -> Route {
        Route(
            path: "character",
            queryItems: [
                .init(name: "page", value: "\(page)")
            ]
        )
    }
}
