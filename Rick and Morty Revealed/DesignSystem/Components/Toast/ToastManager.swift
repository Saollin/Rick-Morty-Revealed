// 
// Toast.swift
// Rick and Morty Revealed
// 

import ComposableArchitecture

@DependencyClient
struct ToastManager {
    var showToast: (_ message: String) async -> ()
}

extension ToastManager: DependencyKey {
    static var liveValue: ToastManager = Self { message in
        await ToastPresenter.shared.show(toast: message)
    }
}

extension DependencyValues {
  var toastManager: ToastManager {
    get { self[ToastManager.self] }
    set { self[ToastManager.self] = newValue }
  }
}
