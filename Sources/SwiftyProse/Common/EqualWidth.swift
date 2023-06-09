//
//  EqualWidth.swift
//  
//
//  Created by Marcel Opitz on 09.11.21.
//

import SwiftUI

struct WidthPreferenceKey: PreferenceKey {

    static var defaultValue: [CGFloat] = []
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

struct EqualWidth: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: WidthPreferenceKey.self,
                            value: [proxy.size.width]
                        )
                }
            )
    }
}

public extension View {
    func equalWidth() -> some View {
        modifier(EqualWidth())
    }
}
