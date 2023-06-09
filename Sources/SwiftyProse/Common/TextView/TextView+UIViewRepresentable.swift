//
//  TextView+UIViewRepresentable.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 05.11.21.
//

import SwiftUI

internal extension TextView {
    struct Representable: UIViewRepresentable {

        @Binding var text: NSAttributedString
        @Binding var calculatedHeight: CGFloat

        let autocapitalization: UITextAutocapitalizationType
        var multilineTextAlignment: TextAlignment
        let truncationMode: NSLineBreakMode
        let isSelectable: Bool
        let isScrollingEnabled: Bool
        var autoDetectionTypes: UIDataDetectorTypes = []
        var linkAttributes: [NSAttributedString.Key: Any] = [:]

        func makeUIView(context: Context) -> UITextView {
            context.coordinator.textView
        }

        func updateUIView(_ view: UITextView, context: Context) {
            context.coordinator.update(representable: self)
        }

        @discardableResult
        func makeCoordinator() -> Coordinator {
            Coordinator(
                text: $text,
                calculatedHeight: $calculatedHeight)
        }
    }
}
