// 
// StatefulPreviewWrapper.swift
// Rick and Morty Revealed
// 

import SwiftUI

public struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content
    
    public var body: some View {
        content($value)
    }
    
    public init(
        _ value: Value,
        content: @escaping (Binding<Value>) -> Content
    ) {
        _value = State(wrappedValue: value)
        self.content = content
    }
}
