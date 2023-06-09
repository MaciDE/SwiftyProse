//
//  CustomHeadingStyles.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 01.04.23.
//

import SwiftyProse
import SwiftUI

@available(iOS 15, *)
public struct CustomHeadingStyle: HeadingStyle {
    
    @Environment(\.proseTextColor)  var proseTextColor
    @Environment(\.proseTextFont) var proseTextFont
    @Environment(\.proseLinkColor) var proseLinkColor
    @Environment(\.proseLinkFont) var proseLinkFont
    
    public func makeBody(configuration: Configuration) -> some View {
        Text(AttributedString(buildAttributedString(
            from: configuration.content,
            attributes: configuration.attributes)))
    }
    
    private func buildAttributedString(
        from nodes: [NodeWrapper],
        attributes: HeadingAttributes?)
    -> NSAttributedString {
        let attributedString = NSMutableAttributedString(
            attributedString: nodes.reducedAttributedString(
                with: proseTextFont, textColor: proseTextColor))
        
        guard let attrs = attributes else { return attributedString }
        
        let range = NSRange(location: 0, length: attributedString.length)
        
        var font = UIFont(name: "Asap-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 16)
        
        switch attrs.level {
        case 1:
            font = font.withSize(32)
        case 2:
            font = font.withSize(28)
        case 3:
            font = font.withSize(24)
        case 4:
            font = font.withSize(20)
        case 5:
            font = font.withSize(18)
        default:
            break
        }
        
        attributedString.addAttribute(.font, value: font, range: range)
        
        return attributedString
    }
}

@available(iOS 15, *)
public extension HeadingStyle where Self == CustomHeadingStyle {
    static var custom: Self { .init() }
}
