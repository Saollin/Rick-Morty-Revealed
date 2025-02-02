// 
// EpisodeDetailsReducer.swift
// Rick and Morty Revealed
// 

import ComposableArchitecture

@Reducer
struct EpisodeDetails {
    @ObservableState
    struct State: Equatable {
        var episodeNumber: Int
        var episode: Episode?
        var isLoading = true
    }
    
    enum Action {
        case onAppear
        case episodeResponse(Result<Episode, Error>)
    }
    
    @Dependency(\.apiClient) var apiClient
    @Dependency(\.toastManager) var toastManager
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                
                return .run { [number = state.episodeNumber] send in
                    try await Task.sleep(seconds: 0.5)
                    await send(.episodeResponse(Result { try await apiClient.episode(number: number) }))
                }
            
            case .episodeResponse(.success(let episode)):
                state.isLoading = false
                state.episode = episode
                return .none
                
            case .episodeResponse(.failure(let error)):
                state.isLoading = false
                return .run { send in
                    await toastManager.showToast(message: error.localizedDescription)
                }
            }
        }
    }
}
