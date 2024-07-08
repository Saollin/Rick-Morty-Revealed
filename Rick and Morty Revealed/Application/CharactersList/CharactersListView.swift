//
// CharactersListView.swift
// Rick and Morty Revealed
//

import ComposableArchitecture
import SwiftUI

struct CharactersListView: View {
    @Perception.Bindable var store: StoreOf<CharactersList>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                HeaderView(title: "List bohaterów")
                instructionButton
                    .padding(.bottom, AppLayout.margin)
                if store.isInstructionVisible {
                    instruction
                } else {
                    list
                }
            }
            .appBackgroundStyle()
        }
    }
    
    var instructionButton: some View {
        LoadButton(
            title: "Wyświetl instrukcję",
            isLoading: false,
            action: {
                store.send(.instructionButtonTapped)
            }
        )
    }
    
    var instruction: some View {
        VStack {
            Spacer(minLength: .zero)
            Text("Aby wyświetlić listę wszystkich bohaterów naciśnij przycisk \"Załaduj\"")
                .multilineTextAlignment(.center)
            LoadButton(
                title: "Załaduj",
                isLoading: store.isLoading,
                isFullWidth: false,
                action: {
                    store.send(.loadButtonTapped)
                }
            )
            Spacer(minLength: .zero)
        }
    }
    
    var list: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEachStore(store.scope(state: \.characters, action: \.characters)) { characterDetailsStore in
                    WithPerceptionTracking {
                        NavigationLink(
                            destination: CharacterDetailsView(
                                store: characterDetailsStore
                            ),
                            label: {
                                CharacterItemView(
                                    character: characterDetailsStore.state.character
                                )
                                    .onAppear {
                                        store.send(.retrieveNextPageIfNeeded(currentItem: characterDetailsStore.id))
                                    }
                            }
                        )
                    }
                }
                ActivityIndicator(
                    style: .large,
                    isAnimating: store.isLoadingPage
                )
            }
        }
    }
}

#Preview {
    CharactersListView(
        store: Store(initialState: CharactersList.State()) {
            CharactersList()
        }
    )
}
