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
    @SwiftUI.Environment(\.dismiss) private var dismiss
    
    var character: Character {
        store.character
    }
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                HeaderView(title: "O bohaterze")
                LoadButton(
                    title: "Wróć do listy bohaterów",
                    action: {
                        dismiss()
                    }
                )
                .padding(.bottom, AppLayout.spacing)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: Constants.spacing) {
                        image
                        info
                        list
                    }
                    
                }
            }
        }
        .navigationBarHidden(true)
        .appBackgroundStyle()
        .sheet(item: $store.scope(state: \.episodeDetails, action: \.episodeDetails)) { episodeDetailsStore in
                EpisodeDetailsView(store: episodeDetailsStore)
        }
    }
    
    private var image: some View {
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
        .clipShape(Circle())
        .overlay {
            Circle()
                .stroke(lineWidth: 4)
                .foregroundStyle(Color.rmYellow)
        }
    }
    
    private var info: some View {
        VStack {
            Text(character.name.uppercased())
                .font(.system(size: 35))
                .sectionTitleStyle()
            
            DescriptionView(
                info: "Stan",
                value: character.status.description
            )
            DescriptionView(
                info: "Płeć",
                value: character.gender.description
            )
            DescriptionView(
                info: "Miejsce pochodzenia",
                value: character.origin.name
            )
            DescriptionView(
                info: "Obecna lokalizacja",
                value: character.location.name
            )
        }
    }
    
    @ViewBuilder
    private var list: some View {
        Text("Lista odcinków")
            .font(.headline)
            .sectionTitleStyle()
        
        LazyVStack {
            ForEach(store.character.episodesNumber, id: \.self) { number in
                WithPerceptionTracking {
                    ListItemView {
                        Spacer(minLength: .zero)
                        Text("Odcinek \(number)")
                        Spacer(minLength: .zero)
                    }
                    .onTapGesture {
                        store.send(.episodeTapped(number: number))
                    }
                }
            }
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
