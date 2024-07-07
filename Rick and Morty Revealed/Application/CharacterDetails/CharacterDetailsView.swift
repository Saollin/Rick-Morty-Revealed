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

    @Perception.Bindable var store: StoreOf<CharacterDetails>
    
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
                        DescriptionView(
                            info: "Status",
                            value: character.status.rawValue
                        )
                        DescriptionView(
                            info: "Gender",
                            value: character.gender.rawValue
                        )
                        DescriptionView(
                            info: "Origin location",
                            value: character.origin.name
                        )
                        DescriptionView(
                            info: "Current location",
                            value: character.location.name
                        )
                    }
                    Text("List of episodes")
                        .font(.headline)
                
                    LazyVStack {
                        ForEach(store.character.episodesNumber, id: \.self) { number in
                            WithPerceptionTracking {
                                Text("Episode \(number)")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .border(.red)
                                    .onTapGesture {
                                        store.send(.episodeTapped(number: number))
                                    }
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Character details")
            .padding(.horizontal, 16.0)
        }
        .sheet(item: $store.scope(state: \.episodeDetails, action: \.episodeDetails)) { episodeDetailsStore in
                EpisodeDetailsView(store: episodeDetailsStore)
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
