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
            VStack {
                HeaderView(title: "O odcinku")
                    .padding(.vertical, AppLayout.margin)
                if let episode = store.episode {
                    Text("Tytuł odcinka \(store.episodeNumber)")
                        .font(.headline)
                    
                    Text(episode.name)
                        .font(.title)
                        .sectionTitleStyle()
                        .padding(.bottom, AppLayout.margin)
                    
                    DescriptionView(info: "Pierwsza emisja", value: episode.airDate)
                    DescriptionView(info: "Kod odcinka", value: episode.episodeCode)
                    DescriptionView(info: "Liczba bohaterów", value: "\(episode.characters.count)")
                } 
                else if store.isLoading {
                    ProgressView()
                        .verticalCenter()
                } else {
                    Text("Brak danych")
                        .verticalCenter()
                }
                Spacer(minLength: .zero)
            }
            .appBackgroundStyle()
            .onAppear {
                store.send(.onAppear)
            }
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
