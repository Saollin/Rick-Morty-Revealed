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
        
        var character: Character
    }
    
    enum Action {
        case backButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backButtonTapped:
                return .none
            }
        }
    }
}
