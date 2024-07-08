// 
// CharacterItemView.swift
// Rick and Morty Revealed
// 

import SwiftUI

struct CharacterItemView: View {
    private enum Constants {
        static let imageWidth: CGFloat = 50.0
        static let itemHeight: CGFloat = 80.0
        static let spacing: CGFloat = 16.0
    }
    
    let character: Character
    
    var body: some View {
        ListItemView {
            AsyncImage(url: URL(string: character.image)!) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .square(with: AppLayout.List.imageHeight)
                    .clipShape(
                        RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color.rmNavy)
                    )
            } placeholder: {
                ZStack {
                    Color.gray.opacity(0.4)
                        .square(with: Constants.imageWidth)
                    ProgressView()
                }
            }
            Text(character.name)
            Spacer(minLength: .zero)
        }
    }
}

#Preview {
    CharacterItemView(character: .mock1)
}
