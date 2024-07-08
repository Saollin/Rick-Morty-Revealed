// 
// CharacterItemView.swift
// Rick and Morty Revealed
// 

import SwiftUI

struct CharacterItemView: View {
    let character: Character
    
    var body: some View {
        ListItemView {
            AsyncImage(url: URL(string: character.image)!) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .square(with: AppLayout.List.imageHeight)
            } placeholder: {
                ZStack {
                    Color.gray.opacity(AppLayout.opacity)
                        .square(with: AppLayout.List.imageHeight)
                    ProgressView()
                }
            }
            .clipShape(
                RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                    .stroke(lineWidth: AppLayout.strokeWidth)
                    .foregroundColor(Color.rmNavy)
            )
            Text(character.name)
            Spacer(minLength: .zero)
        }
    }
}

#Preview {
    CharacterItemView(character: .mock1)
}
