// 
// EpisodeDetailsView.swift
// Rick and Morty Revealed
// 

import SwiftUI
import ComposableArchitecture

struct EpisodeDetailsView: View {
    var store: StoreOf<EpisodeDetails>
    
    var body: some View {
        WithPerceptionTracking {
            Text("Episode \(store.episodeNumber)")
                .font(.title)
            
            if store.isLoading {
                ProgressView()
            }
            if let episode = store.episode {
                VStack {
                    Text(episode.name)
                        .font(.title)
                    DescriptionView(info: "Aired", value: episode.airDate)
                    DescriptionView(info: "Episode code", value: episode.episodeCode)
                    DescriptionView(info: "Characters number", value: "\(episode.characters.count)")
                }
                .padding()
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    EpisodeDetailsView(store: Store(
        initialState: EpisodeDetails.State(episodeNumber: 1)) {
            EpisodeDetails()
        }
   )
}
