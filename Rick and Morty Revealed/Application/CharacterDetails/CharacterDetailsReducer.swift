// 
// CharacterDetailsReducer.swift
// Rick and Morty Revealed
// 

import ComposableArchitecture
import Foundation

@Reducer
struct CharacterDetails {
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: UUID
        
        @Presents var episodeDetails: EpisodeDetails.State?
        var character: Character
    }
    
    enum Action {
        case episodeTapped(number: Int)
        case episodeDetails(PresentationAction<EpisodeDetails.Action>)
    }
    
    @Dependency(\.apiClient) var apiClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .episodeTapped(number: let number):
                state.episodeDetails = EpisodeDetails.State(episodeNumber: number)
                return .none
                
            case .episodeDetails:
                return .none
            }
        }
        .ifLet(\.$episodeDetails, action: \.episodeDetails) {
            EpisodeDetails()
        }
    }
}
