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

extension Episode {
    var airDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        guard let date = formatter.date(from: airDateString) else {
            fatalError("wrong date")
        }
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale(identifier: "pl")
        return formatter.string(from: date)
//        let stringdate = formatter.string(from: date)
//        // print(date) // "janvier 16, 2023"
//        debugPrint(date, stringdate)
//        formatter.dateFormat =
    }
}
