//
//  File.swift
//  
//
//  Created by Marcel Opitz on 09.11.21.
//

import UIKit

internal enum HTMLColors: String {
    case aliceblue
    case antiquewhite
    case aqua
    case aquamarine
    case azure
    case beige
    case bisque
    case black
    case blanchedalmond
    case blue
    case blueviolet
    case brown
    case burlywood
    case cadetblue
    case chartreuse
    case chocolate
    case coral
    case cornflowerblue
    case cornsilk
    case crimson
    case cyan
    case darkblue
    case darkcyan
    case darkgoldenrod
}

internal extension HTMLColors {
    var toUIColor: UIColor? {
        switch self {
        case .aliceblue: return UIColor(hex: "#F0F8FF")
        case .antiquewhite: return UIColor(hex: "#FAEBD7")
        case .aqua: return UIColor(hex: "#00FFFF")
        case .aquamarine: return UIColor(hex: "#7FFFD4")
        case .azure: return UIColor(hex: "#F0FFFF")
        case .beige: return UIColor(hex: "#F5F5DC")
        case .bisque: return UIColor(hex: "#FFE4C4")
        case .black: return UIColor(hex: "#000000")
        case .blanchedalmond: return UIColor(hex: "#FFEBCD")
        case .blue: return UIColor(hex: "#0000FF")
        case .blueviolet: return UIColor(hex: "#8A2BE2")
        case .brown: return UIColor(hex: "#A52A2A")
        case .burlywood: return UIColor(hex: "#DEB887")
        case .cadetblue: return UIColor(hex: "#5F9EA0")
        case .chartreuse: return UIColor(hex: "#7FFF00")
        case .chocolate: return UIColor(hex: "#D2691E")
        case .coral: return UIColor(hex: "#FF7F50")
        case .cornflowerblue: return UIColor(hex: "#6495ED")
        case .cornsilk: return UIColor(hex: "#FFF8DC")
        case .crimson: return UIColor(hex: "#DC143C")
        case .cyan: return UIColor(hex: "#00FFFF")
        case .darkblue: return UIColor(hex: "#00008B")
        case .darkcyan: return UIColor(hex: "#008B8B")
        case .darkgoldenrod: return UIColor(hex: "#B8860B")
        }
    }
}
