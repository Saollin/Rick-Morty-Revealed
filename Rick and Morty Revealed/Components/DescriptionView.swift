// 
// DescriptionView.swift
// Rick and Morty Revealed
// 

import SwiftUI

struct DescriptionView: View {
    let info: String
    let value: String
    
    var body: some View {
        HStack {
            Text(info)
                .italic()
            Spacer()
            Text(value)
        }
    }
}
