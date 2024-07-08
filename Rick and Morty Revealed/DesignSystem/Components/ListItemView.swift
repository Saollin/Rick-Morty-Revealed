// 
// ListItemView.swift
// Rick and Morty Revealed
// 

import SwiftUI

struct ListItemView<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content:  @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: AppLayout.spacing) {
            content()
        }
        .frame(height: AppLayout.List.itemHeight)
        .padding(.horizontal, 16.0)
        .background(Color.rmNavy.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
