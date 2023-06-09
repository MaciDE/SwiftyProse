//
//  TextView.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 05.11.21.
//

import SwiftUI

/// A SwiftUI TextView implementation that supports both scrolling and auto-sizing layouts
internal struct TextView: View {

    @Binding private var text: NSAttributedString

    @State private var calculatedHeight: CGFloat = 44
    
    private var autocapitalization: UITextAutocapitalizationType = .sentences
    private var multilineTextAlignment: TextAlignment = .leading
    private var truncationMode: NSLineBreakMode = .byTruncatingTail
    private var isSelectable: Bool = true
    private var isScrollingEnabled: Bool = false
    private var autoDetectionTypes: UIDataDetectorTypes = []
    private var linkAttributes: [NSAttributedString.Key: Any] = [:]

    /// Creates a new TextView that supports `NSAttributedString`
    /// - Parameters:
    ///   - text: A binding to the attributed text
    init(_ text: Binding<NSAttributedString>) {
        _text = text
    }

    var body: some View {
        Representable(
            text: $text,
            calculatedHeight: $calculatedHeight,
            autocapitalization: autocapitalization,
            multilineTextAlignment: multilineTextAlignment,
            truncationMode: truncationMode,
            isSelectable: isSelectable,
            isScrollingEnabled: isScrollingEnabled,
            autoDetectionTypes: autoDetectionTypes,
            linkAttributes: linkAttributes
        )
        .frame(
            minHeight: isScrollingEnabled ? 0 : calculatedHeight,
            maxHeight: isScrollingEnabled ? .infinity : calculatedHeight
        )
    }

}

extension TextView: Equatable {
    public static func == (
        lhs: TextView,
        rhs: TextView)
    -> Bool {
        lhs.text == rhs.text &&
        lhs.calculatedHeight == rhs.calculatedHeight &&
        lhs.autocapitalization == rhs.autocapitalization &&
        lhs.multilineTextAlignment == rhs.multilineTextAlignment &&
        lhs.truncationMode == rhs.truncationMode &&
        lhs.isSelectable == rhs.isSelectable &&
        lhs.isScrollingEnabled == rhs.isScrollingEnabled &&
        lhs.autoDetectionTypes == rhs.autoDetectionTypes &&
        lhs.text.isEqual(to: rhs.text)
    }
}

internal extension TextView {
    /// Enables auto detection for the specified types
    /// - Parameter types: The types to detect
    func autoDetectDataTypes(_ types: UIDataDetectorTypes) -> TextView {
        var view = self
        view.autoDetectionTypes = types
        return view
    }

    /// Specifies the capitalization style to apply to the text
    /// - Parameter style: The capitalization style
    func autocapitalization(_ style: UITextAutocapitalizationType) -> TextView {
        var view = self
        view.autocapitalization = style
        return view
    }

    /// Specifies the alignment of multi-line text
    /// - Parameter alignment: The text alignment
    func multilineTextAlignment(_ alignment: TextAlignment) -> TextView {
        var view = self
        view.multilineTextAlignment = alignment
        return view
    }

    /// Specifies whether the text can be selected
    /// - Parameter isSelectable: If true, the text can be selected
    func isSelectable(_ isSelectable: Bool) -> TextView {
        var view = self
        view.isSelectable = isSelectable
        return view
    }

    /// Specifies whether the field can be scrolled. If true, auto-sizing will be disabled
    /// - Parameter isScrollingEnabled: If true, scrolling will be enabled
    func enableScrolling(_ isScrollingEnabled: Bool) -> TextView {
        var view = self
        view.isScrollingEnabled = isScrollingEnabled
        return view
    }

    /// Specifies the truncation mode for this field
    /// - Parameter mode: The truncation mode
    func truncationMode(_ mode: Text.TruncationMode) -> TextView {
        var view = self
        switch mode {
        case .head: view.truncationMode = .byTruncatingHead
        case .tail: view.truncationMode = .byTruncatingTail
        case .middle: view.truncationMode = .byTruncatingMiddle
        @unknown default:
            fatalError("Unknown text truncation mode")
        }
        return view
    }

    func setLinkAttributes(_ attributes: [NSAttributedString.Key: Any]) -> TextView {
        var view = self
        view.linkAttributes = attributes
        return view
    }
}
