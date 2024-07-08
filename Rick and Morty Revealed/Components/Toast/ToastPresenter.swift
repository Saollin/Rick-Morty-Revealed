// 
// ToastPresenter.swift
// Rick and Morty Revealed
// 

import SwiftUI
import ComposableArchitecture

class ToastPresenter {
    private enum Constants {
        static let toastHeight: CGFloat = 100.0
        static let toastBottomPadding: CGFloat = 30.0
    }
    static let shared = ToastPresenter()
    
    private init() {}
    private var toastWindow: UIWindow?
    
    @MainActor
    func show(
        toast: String
    ) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        toastWindow = UIWindow(windowScene: scene)
        toastWindow?.backgroundColor = .clear
        
        guard let screenBounds = scene.keyWindow?.bounds else { return }
        
        let startFrame = CGRect(
            x: .zero,
            y: screenBounds.height,
            width: screenBounds.width,
            height: Constants.toastHeight
        )
        
        let endFrame = startFrame.offsetBy(
            dx: .zero,
            dy: -Constants.toastHeight - Constants.toastBottomPadding
        )

        toastWindow?.frame = startFrame
        
        let view = ToastView(
            style: .error,
            message: toast
        )
        
        toastWindow?.rootViewController = UIHostingController(rootView: view)
        toastWindow?.rootViewController?.view.backgroundColor = .clear
        toastWindow?.makeKeyAndVisible()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.toastWindow?.frame = endFrame
        })
        
        // Hide the toast automatically after 2 seconds with slide up animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5, animations: {
                self.toastWindow?.frame = startFrame
            }) { _ in
                self.toastWindow?.isHidden = true
                self.toastWindow = nil
            }
        }
    }
}
