// 
// DescriptionView.swift
// Rick and Morty Revealed
// 

import SwiftUI

struct DescriptionView: View {
    let info: String
    let value: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(info)
                .font(.footnote)
            
            Text(value)
                .descriptionStyle()
        }
    }
}

#Preview {
    DescriptionView(
        info: "Miejsce pochodzenia",
        value: "Earth (replacement dimension)"
    )
}
