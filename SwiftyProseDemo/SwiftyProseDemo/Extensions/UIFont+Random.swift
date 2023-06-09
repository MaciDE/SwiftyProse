//
//  UIFont+Random.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 01.05.23.
//

import UIKit

extension UIFont {
    static func random(size: CGFloat = 14) -> UIFont {
        UIFont(name: UIFont.familyNames.randomElement()!, size: size)!
    }
}
