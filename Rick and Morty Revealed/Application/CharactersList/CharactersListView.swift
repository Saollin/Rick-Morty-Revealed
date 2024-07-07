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
            NavigationView {
                VStack {
                    HStack {
                        Button {
                            store.send(.loadButtonTapped)
                        } label: {
                            Text(store.isListHidden
                                 ? "Load list"
                                 : "Hide list")
                        }
                    }
                    .frame(height: 50)
                    Divider()
                    ScrollView {
                        Group {
                            if store.isListHidden {
                                VStack {
                                    Spacer(minLength: .zero)
                                    Text("To display characters click on button")
                                    Spacer(minLength: .zero)
                                }
                            } else if store.isLoading {
                                VStack {
                                    Spacer()
                                    ActivityIndicator(
                                        style: .large,
                                        isAnimating: store.isLoading
                                    )
                                    Spacer()
                                }
                            } else {
                                LazyVStack {
                                    ForEachStore(store.scope(state: \.characters, action: \.characters)) { characterDetailsStore in
                                        WithPerceptionTracking {
                                            NavigationLink(
                                                destination: CharacterDetailsView(store: characterDetailsStore),
                                                label: {
                                                    CharacterItemView(character: characterDetailsStore.state.character)
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
                        .padding()
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
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
