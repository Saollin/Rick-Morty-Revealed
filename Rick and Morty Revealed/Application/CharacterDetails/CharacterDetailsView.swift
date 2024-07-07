// 
// CharacterDetailsView.swift
// Rick and Morty Revealed
// 

import ComposableArchitecture
import SwiftUI

struct CharacterDetailsView: View {
    private enum Constants {
        static let imageWidth: CGFloat = 250.0
        static let itemHeight: CGFloat = 80.0
        static let spacing: CGFloat = 16.0
    }

    var store: StoreOf<CharacterDetails>
    
    var character: Character {
        store.character
    }
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(spacing: Constants.spacing) {
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
                        .font(.title)
                    VStack {
                        descriptionView("Status", value: character.status.rawValue)
                        descriptionView("Gender", value: character.gender.rawValue)
                        descriptionView("Origin location", value: character.origin.name)
                        descriptionView("Current location", value: character.location.name)
                    }
                    Text("List of episodes")
                        .font(.headline)
                
                    LazyVStack {
                        ForEach(character.episodesNumber, id: \.self) {
                            Text("Episode \($0)")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .border(.red)
                        }
                    }
                }
                
            }
            .padding(.horizontal, 16.0)
        }
    }
    
    func descriptionView(_ info: String, value: String) -> some View {
        HStack {
            Text(info)
                .italic()
            Spacer()
            Text(value)
        }
    }
}

#Preview {
    CharacterDetailsView(
        store: Store(initialState: CharacterDetails.State(id: UUID(), character: .mock1)) {
            CharacterDetails()
        }
    )
}
