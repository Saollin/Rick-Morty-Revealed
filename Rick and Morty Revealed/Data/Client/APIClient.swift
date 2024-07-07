// 
// APIClient.swift
// Rick and Morty Revealed
// 

import Foundation
import ComposableArchitecture

@DependencyClient
struct APIClient {
    var characters: (_ page: Int) async throws -> [Character]
    var episode: (_ number: Int) async throws -> Episode
}

extension APIClient: DependencyKey {
    static var liveValue: APIClient = APIClient(
        characters: { page in
            let page: Pagination<Character> = try await APIManager.shared.get(.charactersPage(page))
            return page.results
        },
        episode: { number in
            return try await APIManager.shared.get(.episode(number))
        }
    )
}

extension APIClient: TestDependencyKey {
    static var previewValue: APIClient = Self(
        characters: { _ in [ .mock1, .mock2 ] },
        episode: { _ in .mock }
    )
}

extension DependencyValues {
  var apiClient: APIClient {
    get { self[APIClient.self] }
    set { self[APIClient.self] = newValue }
  }
}
