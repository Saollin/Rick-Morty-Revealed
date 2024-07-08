// 
// ToastPresenter.swift
// Rick and Morty Revealed
// 

import ComposableArchitecture

@DependencyClient
public struct ToastPresenter {
    public var observer: @Sendable () -> AsyncStream<String>
    public var present: @Sendable (String) async -> Void
}

extension ToastPresenter: DependencyKey {
    static var liveValue: ToastPresenter = ToastPresenter(
        observer: {
            <#code#>
        }, 
        present: { <#String#> in
            <#code#>
        }
    )
}
