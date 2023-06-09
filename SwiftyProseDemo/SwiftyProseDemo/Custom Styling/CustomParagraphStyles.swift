//
//  CustomParagraphStyles.swift
//  SwiftyProseDemo
//
//  Created by Marcel Opitz on 08.06.23.
//

import SwiftyProse
import SwiftUI

@available(iOS 15, *)
public struct CustomParagraphStyle: ParagraphStyle {
    
    @Environment(\.proseTextColor)  var proseTextColor
    @Environment(\.proseTextFont) var proseTextFont
    
    public func makeBody(configuration: Configuration) -> some View {
        Text(
            AttributedString(buildAttributedString(from: configuration.content))
        )
            .textCase(.uppercase)
            .multilineTextAlignment(.center)
    }
    
    private func buildAttributedString(
        from nodes: [NodeWrapper]
    ) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(
            attributedString: nodes.reducedAttributedString(
                with: proseTextFont, textColor: proseTextColor))
        return attributedString
    }
}

@available(iOS 15, *)
public extension ParagraphStyle where Self == CustomParagraphStyle {
    static var custom: Self { .init() }
}
