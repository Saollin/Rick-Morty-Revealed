// 
// APIClient.swift
// Rick and Morty Revealed
// 

import Foundation
import ComposableArchitecture

@DependencyClient
struct APIClient {
    var characters: (_ page: Int) async throws -> [Character]
}

extension APIClient: DependencyKey {
    static var liveValue: APIClient = APIClient(
        characters: { page in
            let page: Pagination<Character> = try await APIManager.shared.get(.charactersPage(page))
            return page.results
        }
    )
}

extension APIClient: TestDependencyKey {
    static var previewValue: APIClient = Self { _ in [ .mock1, .mock2 ]}
}

extension DependencyValues {
  var apiClient: APIClient {
    get { self[APIClient.self] }
    set { self[APIClient.self] = newValue }
  }
}
