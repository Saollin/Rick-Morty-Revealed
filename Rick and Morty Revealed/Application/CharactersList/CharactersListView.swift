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

struct FadeInFullScreenCoverModifier<V: View>: ViewModifier {
    @Binding var isPresented: Bool
    @ViewBuilder let view: () -> V
    @State var isPresentedInternal = false
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: Binding<Bool>(
                get: { isPresented },
                set: { isPresentedInternal = $0 }
            )) {
                Group {
                    if isPresentedInternal {
                        view()
                            .transition(.opacity)
                            .onDisappear { isPresented = false }
                    }
                }
                .onAppear { isPresentedInternal = true }
//                .presentationBackground(.clear)
            }
            .transaction {
                // Disable default fullScreenCover animation
                $0.disablesAnimations = true
                // Add custom animation
                $0.animation = .easeInOut
            }
    }
}
extension View {
    func fadeInFullScreenCover<V: View>(
        isPresented: Binding<Bool>,
        content: @escaping () -> V
    ) -> some View {
        modifier(FadeInFullScreenCoverModifier(
            isPresented: isPresented,
            view: content
        ))
    }
}
