//
//  TextRenderable.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import SwiftUI

public protocol TextRenderable {
    func attributedText(with font: UIFont, textColor: UIColor) -> NSAttributedString
}
