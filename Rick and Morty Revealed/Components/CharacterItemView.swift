// 
// CharacterItemView.swift
// Rick and Morty Revealed
// 

import SwiftUI

extension View {
    func square(with width: CGFloat) -> some View {
        self
            .frame(width: width, height: width)
    }
}
struct CharacterItemView: View {
    private enum Constants {
        static let imageWidth: CGFloat = 70.0
        static let itemHeight: CGFloat = 80.0
        static let spacing: CGFloat = 16.0
    }
    
    let character: Character
    
    var body: some View {
        HStack(alignment: .center, spacing: Constants.spacing) {
            AsyncImage(url: URL(string: character.image)!) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .square(with: Constants.imageWidth)
            } placeholder: {
                ZStack {
                    Color.gray.opacity(0.4)
                        .square(with: Constants.imageWidth)
                    ProgressView()
                }
            }
            Text(character.name)
            Spacer(minLength: .zero)
            Text(character.gender.rawValue)
        }
        .frame(height: Constants.itemHeight)
        .padding(.vertical, 8.0)
        .padding(.horizontal, 16.0)
        .border(.brown)
    }
}

#Preview {
    CharacterItemView(character: .mock1)
}
