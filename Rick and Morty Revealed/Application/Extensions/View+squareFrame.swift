// 
// View+squareFrame.swift
// Rick and Morty Revealed
// 

import SwiftUI

extension View {
    func square(with width: CGFloat) -> some View {
        self
            .frame(width: width, height: width)
    }
}
