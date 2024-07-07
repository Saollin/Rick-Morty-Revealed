// 
// ActivityIndicator.swift
// Rick and Morty Revealed
// 

import SwiftUI

public struct ActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    let color: UIColor
    var isAnimating: Bool
    
    public init(
        style: UIActivityIndicatorView.Style,
        color: UIColor = .black,
        isAnimating: Bool
    ) {
        self.style = style
        self.color = color
        self.isAnimating = isAnimating
    }
    
    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.color = color
        return activityIndicator
    }
    
    public func updateUIView(
        _ uiView: UIActivityIndicatorView,
        context: UIViewRepresentableContext<ActivityIndicator>
    ) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
