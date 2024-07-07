//
//  Rick_and_Morty_RevealedApp.swift
//  Rick and Morty Revealed
//
//  Created by Grzegorz Janosz on 04/07/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct RickAndMortyRevealedApp: App {
    var body: some Scene {
        WindowGroup {
            CharactersListView(
                store: Store(initialState: CharactersList.State()) {
                    CharactersList()
                        ._printChanges()
                })
        }
    }
}
