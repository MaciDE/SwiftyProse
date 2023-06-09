//
//  UIFont+Extensions.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 05.11.21.
//

import SwiftUI

internal extension UIFont {
    func italic() -> UIFont {
        let existingTraits = fontDescriptor.symbolicTraits
        guard let descriptor = fontDescriptor.withSymbolicTraits([existingTraits, .traitItalic]) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }

    func bold() -> UIFont {
        let existingTraits = fontDescriptor.symbolicTraits
        guard let descriptor = fontDescriptor.withSymbolicTraits([existingTraits, .traitBold]) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
