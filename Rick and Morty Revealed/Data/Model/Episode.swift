// 
// Episode.swift
// Rick and Morty Revealed
//

import Foundation

struct Episode: Decodable, Equatable, Identifiable, Sendable {
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCode = "epiode"
        case id, name, characters
    }
    
    var id: Int
    var name: String
    var airDate: String
    var episodeCode: String
    var characters: [String]
}

extension Episode {
    static let mock = Episode(
        id: 28, 
        name: "The Ricklantis Mixup",
        airDate: "September 10, 2017",
        episodeCode: "S03E07",
        characters: [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2",
            "https://rickandmortyapi.com/api/character/4",
            "https://rickandmortyapi.com/api/character/8"
        ]
    )
}
