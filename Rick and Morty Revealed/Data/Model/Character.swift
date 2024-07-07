//
//  Character.swift
//  Rick and Morty Revealed
//

import Foundation

struct Character: Decodable, Equatable, Identifiable {
    enum Gender: String, Decodable {
        case Female, Male, Genderless, unknown
    }
    
    enum Status: String, Decodable {
        case Alive, Dead, unknown
    }
    
    struct LocationInfo: Decodable, Equatable {
        var name: String
        var url: String
    }
    
    var id: Int
    var name: String
    var status: Status
    var species: String
    var type: String
    var gender: Gender
    var origin: LocationInfo
    var location: LocationInfo
    var image: String
    var episode: [String]
    var url: String
    var created: Date
}

extension Character {
    var episodesNumber: [Int] {
        episode
            .map { URL(string: $0) }
            .map { $0?.lastPathComponent }
            .compactMap { $0 }
            .map { Int($0) }
            .compactMap { $0 }
    }
}

extension Character {
    static let mock1 = Character(
        id: 1,
        name: "Rick Sanchez",
        status: .Alive,
        species: "Human",
        type: "",
        gender: .Male,
        origin: .init(
            name: "Earth (C-137)",
            url: "https://rickandmortyapi.com/api/location/1"
        ),
        location: .init(
            name: "Citadel of Ricks",
            url: "https://rickandmortyapi.com/api/location/3"
        ),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2"
        ],
        url: "https://rickandmortyapi.com/api/character/1",
        created: Date()
    )
    static let mock2 = Character(
        id: 2,
        name: "Morty Smith",
        status: .Alive,
        species: "Human",
        type: "",
        gender: .Male,
        origin: .init(
            name: "unknown",
            url: ""
        ),
        location: .init(
            name: "Citadel of Ricks",
            url: "https://rickandmortyapi.com/api/location/3"
        ),
        image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        episode: [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2"
        ],
        url: "https://rickandmortyapi.com/api/character/2",
        created: Date()
    )}
