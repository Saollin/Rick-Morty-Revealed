// 
// DataViewModel.swift
// Rick and Morty Revealed
// 

import Foundation

extension Character.Gender {
    var description: String {
        switch self {
        case .Female:
            return "Kobieta"
        case .Male:
            return "Mężczyzna"
        case .Genderless:
            return "Inna"
        case .unknown:
            return "Brak danych"
        }
    }
}

extension Character.Status {
    var description: String {
        switch self {
        case .Alive:
            return "Żywy"
        case .Dead:
            return "Martwy"
        case .unknown:
            return "Brak danych"
        }
    }
}
