// 
// LoadButtonView.swift
// Rick and Morty Revealed
// 

import SwiftUI

struct LoadButton: View {
    @Namespace private var animation
    @SwiftUI.Environment(\.isEnabled) private var isEnabled: Bool
    
    let title: String
    var isLoading: Bool = false
    var isFullWidth: Bool = true
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            if isLoading {
                ZStack {
                    Circle()
                        .fill(Color.rmYellow)
                        .frame(height: AppLayout.buttonHeight)
                    
                    ProgressView()
                        .tint(.rmWhite)
                }
                .matchedGeometryEffect(id: "button", in: animation)
            } else {
                Text(title)
                    .padding(.horizontal, AppLayout.margin)
                    .font(.body)
                    .foregroundStyle(isEnabled ? Color.rmNavy : .secondary.opacity(0.3))
                    .frame(maxWidth: isFullWidth ? .infinity : nil)
                    .frame(height: AppLayout.buttonHeight)
                    .background(RoundedRectangle(cornerRadius: AppLayout.cornerRadius).fill(isEnabled ? Color.rmYellow : .gray.opacity(0.5)))
                    .matchedGeometryEffect(id: "button", in: animation)
            }
        }
    }
}

#Preview {
    VStack {
        LoadButton(
            title: "Załaduj",
            isLoading: false,
            action: {}
        )
        LoadButton(
            title: "Załaduj",
            isLoading: false,
            isFullWidth: false,
            action: {}
        )
    }
}
