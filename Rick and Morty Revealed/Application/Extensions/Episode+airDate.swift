// 
// Episode+airDate.swift
// Rick and Morty Revealed
// 

import Foundation

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
    }
}
