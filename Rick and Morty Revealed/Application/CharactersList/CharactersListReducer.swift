//
// CharactersListReducer.swift
// Rick and Morty Revealed
//

import Foundation
import ComposableArchitecture

@Reducer
struct CharactersList {
    @ObservableState
    struct State: Equatable {
        var toastContent: Toast? = nil
        var characters = IdentifiedArrayOf<CharacterDetails.State>()
        
        var currentPage = 1
        var isLoading = false
        var isLoadingPage = false
        var isLoaded = false
        var isListHidden = true
        
        func isLastItem(_ item: UUID) -> Bool {
            let itemIndex = characters.firstIndex(where: { $0.id == item })
            return itemIndex == characters.endIndex - 1
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case charactersResponse(Result<[Character], Error>)
        case loadingActive(Bool)
        case loadingPageActive(Bool)
        case loadButtonTapped
        case retrieve
        case retrieveNextPageIfNeeded(currentItem: UUID)
        case characters(IdentifiedActionOf<CharacterDetails>)
        case onDisappear
    }
    
    @Dependency(\.apiClient) var apiClient
    @Dependency(\.uuid) var uuid
    @Dependency(\.toastManager) var toastManager
    
    private enum CancelID { case characters }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .loadButtonTapped:
                guard state.isLoaded else {
                    return .run { send in
                        await send(.retrieve)
                    }
                    .cancellable(id: CancelID.characters)
                }
                state.isListHidden.toggle()
                return .none
                
            case .retrieve:
                state.characters = []
                state.currentPage = 1
                state.isLoading = true
                return .run(operation: { [page = state.currentPage] send in
                        await send(.charactersResponse(Result { try await apiClient.characters(page)}))
                    })
                    .cancellable(id: CancelID.characters)
                
            case .retrieveNextPageIfNeeded(currentItem: let item):
                guard
                    state.isLastItem(item),
                    !state.isLoadingPage
                else { return .none }
                
                state.currentPage += 1
                state.isLoadingPage = true
                return .run(operation: { [page = state.currentPage] send in
                        await send(.charactersResponse(Result { try await apiClient.characters(page)}))
                    })
                    .cancellable(id: CancelID.characters)
                
            case .charactersResponse(.success(let characters)):
                characters.forEach { character in
                    state.characters.append(CharacterDetails.State(
                        id: uuid(),
                        character: character
                    ))
                }
                state.isLoadingPage = false
                state.isLoading = false
                state.isLoaded = true
                state.isListHidden = false
                
                return .none
                
            case .charactersResponse(.failure(let error)):
                state.isLoadingPage = false
                state.isLoading = false
                return .run { send in
                    await toastManager.showToast(message: error.localizedDescription)
                }
                
            case .loadingActive(let isLoading):
                state.isLoading = isLoading
                return .none
                
            case .loadingPageActive(let isLoading):
                state.isLoadingPage = isLoading
                return .none

            case .onDisappear:
                return .cancel(id: CancelID.characters)
            
            case .characters:
                return .none
                
            case .binding(_):
                return .none
            }
        }
        .forEach(\.characters, action: \.characters) {
            CharacterDetails()
        }
    }
}
