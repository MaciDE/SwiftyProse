//
//  TextView+Coordinator.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 05.11.21.
//

import SwiftUI

internal extension TextView.Representable {
    final class Coordinator: NSObject {
        internal let textView: UITextView

        private var originalText: NSAttributedString = .init()
        private var text: Binding<NSAttributedString>
        private var calculatedHeight: Binding<CGFloat>
        
        private var cacheSize: CGSize
        private var didCancelCalculation: Bool = false
        
        init(
            text: Binding<NSAttributedString>,
            calculatedHeight: Binding<CGFloat>)
        {
            textView = UITextView()
            textView.backgroundColor = .clear
            textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            textView.isEditable = false

            self.text = text
            self.calculatedHeight = calculatedHeight
            self.cacheSize = CGSize(width: 0, height: calculatedHeight.wrappedValue)
            
            super.init()
        }
    }
}

internal extension TextView.Representable.Coordinator {
    func update(representable: TextView.Representable) {
        textView.attributedText = representable.text
        textView.dataDetectorTypes = representable.autoDetectionTypes
        textView.isScrollEnabled = representable.isScrollingEnabled
        textView.isSelectable = representable.isSelectable
        textView.linkTextAttributes = representable.linkAttributes
        
        if !representable.isScrollingEnabled {
            textView.textContainer.lineFragmentPadding = 0
            textView.textContainerInset = .zero
        }

        recalculateHeight()
    }

    func recalculateHeight() {
        let newSize = textView.sizeThatFits(
            CGSize(width: textView.frame.width, height: .greatestFiniteMagnitude))
        
        guard calculatedHeight.wrappedValue != newSize.height else { return }
        
        DispatchQueue.main.async {
            self.calculatedHeight.wrappedValue = newSize.height
            self.textView.setNeedsDisplay()
        }
    }
}
