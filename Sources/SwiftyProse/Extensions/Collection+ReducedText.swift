//
//  Collection+ReducedText.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import SwiftUI

public extension Collection where Element == NodeWrapper {
    private func reducedTextContent(with font: UIFont, textColor: UIColor) -> [NSAttributedString] {
        var textNodes: [TextRenderable] = []
        
        forEach { content in
            switch content {
            case .text(let text):
                textNodes.append(text)
            case .hardBreak(let text):
                textNodes.append(text)
            default:
                break
            }
        }
        
        return textNodes.map({ $0.attributedText(with: font, textColor: textColor) })
    }
    
    func reducedAttributedString(with font: UIFont, textColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        
        for attributedText in reducedTextContent(with: font, textColor: textColor) {
            attributedString.append(attributedText)
        }
    
        return attributedString
    }
}

public extension Collection where Element == TextNode {
    private func reducedTextContent(with font: UIFont, textColor: UIColor) -> [NSAttributedString] {
        return self.map({ $0.attributedText(with: font, textColor: textColor) })
    }
    
    func reducedAttributedString(with font: UIFont, textColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        
        for attributedText in reducedTextContent(with: font, textColor: textColor) {
            attributedString.append(attributedText)
        }
    
        return attributedString
    }
}
