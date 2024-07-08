//
// ToastView.swift
// Rick and Morty Revealed
//

import SwiftUI

struct Toast: Equatable {
    var style: ToastStyle
    var message: String
}

enum ToastStyle {
    case error, warning, success, info
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return .rmError
        case .warning: return .orange
        case .info: return .blue
        case .success: return .green
        }
    }
}

struct ToastView: View {
    var style: ToastStyle
    var message: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(message)
                .font(Font.caption)
                .foregroundColor(Color(.white))
        }
        .padding(.vertical, 16)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(style.themeColor)
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}
