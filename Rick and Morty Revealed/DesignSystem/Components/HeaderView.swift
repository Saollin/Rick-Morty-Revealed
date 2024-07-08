// 
// HeaderView.swift
// Rick and Morty Revealed
// 

import SwiftUI

struct HeaderView: View {
    let title: String
    
    var body: some View {
        VStack {
            Text("Rick & Morty".uppercased())
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.rmNavy)
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    HeaderView(title: "Lista")
}
