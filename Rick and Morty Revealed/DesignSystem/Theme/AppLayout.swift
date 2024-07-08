// 
// Layout.swift
// Rick and Morty Revealed
// 

import Foundation

enum AppLayout {
    static let spacing: CGFloat = 16.0
    static let cornerRadius: CGFloat = 16.0
    static let buttonHeight: CGFloat = 60.0
    static let margin: CGFloat = 16.0
    
    enum List {
        static let itemOpacity: CGFloat = 0.7
        static let itemHeight: CGFloat = 70.0
        static let imageHeight: CGFloat = 55.0
    }
    
    enum Details {
        static let imageWidth: CGFloat = 250.0
        static let itemHeight: CGFloat = 70.0
        static let spacing: CGFloat = 16.0
    }
}
