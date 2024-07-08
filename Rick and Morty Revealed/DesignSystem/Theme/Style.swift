// 
// BackgroundStyle.swift
// Rick and Morty Revealed
// 

import SwiftUI

extension View {
    func appBackgroundStyle() -> some View {
        self
            .padding(.horizontal, AppLayout.margin)
            .foregroundStyle(Color.rmWhite)
            .background(Color.rmPrimary)
            .edgesIgnoringSafeArea(.bottom)
    }
    
    func sectionTitleStyle() -> some View {
        self
            .padding(AppLayout.margin)
            .foregroundStyle(Color.rmNavy)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                .fill( Color.rmYellow))
    }
    
    func descriptionStyle() -> some View {
        self
            .padding(.horizontal, AppLayout.margin)
            .padding(.vertical, 4.0)
            .foregroundStyle(Color.rmNavy)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                    .fill( Color.rmWhite.opacity(AppLayout.opacity)))
    }
}
