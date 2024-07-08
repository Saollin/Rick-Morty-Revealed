// 
// EpisodeModel.swift
// Rick and Morty Revealed
// 

import Foundation

struct EpisodeModel: Equatable  {
    var id: Int
    var name: String
    var airDate: Date
    var episodeCode: String
    var characters: [String]
}
