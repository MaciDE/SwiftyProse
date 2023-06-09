//
//  HardBreakNode.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import SwiftUI

/*
    group: inline
    content: -
*/
public struct HardBreakNode: Codable, Equatable {
    
    public var type: String = "hardBreak"
    
    public init(type: String = "hardBreak") {
        self.type = type
    }
}

// MARK: HardBreakNode + TextRenderable
extension HardBreakNode: TextRenderable {
    public func attributedText(with font: UIFont, textColor: UIColor) -> NSAttributedString {
        NSAttributedString(string: "\n")
    }
}
