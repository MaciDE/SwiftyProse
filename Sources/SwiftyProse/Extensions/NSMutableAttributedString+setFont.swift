//
//  NSMutableAttributedString+setFont.swift
//  
//
//  Created by Marcel Opitz on 01.04.23.
//

import UIKit

extension NSMutableAttributedString {
    func setFont(_ font: UIFont, textColor: UIColor? = nil) {
        let fontFamilyName = font.familyName
        
        beginEditing()
        enumerateAttribute(
            NSAttributedString.Key.font,
            in: NSMakeRange(0, length),
            options: []) { (value, range, stop) in
                if let oldFont = value as? UIFont {
                    guard let descriptor = oldFont
                        .fontDescriptor
                        .withFamily(fontFamilyName)
                        .withSymbolicTraits(oldFont.fontDescriptor.symbolicTraits)
                    else { return }
                    // Default font is always Helvetica 12
                    // See: https://developer.apple.com/documentation/foundation/nsattributedstring?language=objc
                    let size = font.pointSize * (oldFont.pointSize / 12)
                    let newFont = UIFont(descriptor: descriptor, size: size)
                    addAttribute(NSAttributedString.Key.font, value: newFont, range: range)
                }
            }
        if let textColor = textColor {
            addAttributes(
                [NSAttributedString.Key.foregroundColor: textColor],
                range: NSRange(location: 0, length: length))
        }
        endEditing()
        
    }
}
