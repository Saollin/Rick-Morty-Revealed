// 
// Text+verticalCenter.swift
// Rick and Morty Revealed
// 

import SwiftUI

extension View {
    func verticalCenter() -> some View {
        VStack {
            Spacer(minLength: .zero)
            self
            Spacer(minLength: .zero)
        }
    }
}
