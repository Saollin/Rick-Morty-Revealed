// 
// Router+Characters.swift
// Rick and Morty Revealed
// 

import Foundation

extension Route {
    static func charactersPage(_ page: Int) -> Route {
        Route(
            path: "character",
            queryItems: [
                .init(name: "page", value: "\(page)")
            ]
        )
    }
}
