//
//  Styling.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import SwiftUI

public enum BulletStyle: String {
    case bullet
    case circle
    case square
    
    public var symbol: String {
        switch self {
        case .bullet:
            return "•"
        case .circle:
            return "⚬"
        case .square:
            return "▪"
        }
    }

}

public enum DefaultProseStyle {
    public static var nodeSpacing: CGFloat = 0.0
    public static var textColor: UIColor = UIColor.label
    public static var textFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    public static var headingFont: UIFont = UIFont.systemFont(ofSize: 32.0)
    public static var linkColor: UIColor = UIColor.blue
    public static var linkFont: UIFont = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    public static var paragraphLineSpacing: CGFloat = 4.0
}

// MARK: EnvironmentKeys
private struct ProseNodeSpacingKey: EnvironmentKey {
    static let defaultValue = DefaultProseStyle.nodeSpacing
}

private struct ProseTextColorKey: EnvironmentKey {
    static let defaultValue = DefaultProseStyle.textColor
}

private struct ProseHeadingTextColorKey: EnvironmentKey {
    static let defaultValue = DefaultProseStyle.textColor
}

private struct ProseLinkColorKey: EnvironmentKey {
    static let defaultValue = DefaultProseStyle.linkColor
}

private struct ProseTextFontKey: EnvironmentKey {
    static let defaultValue = DefaultProseStyle.textFont
}

private struct ProseHeadingFontKey: EnvironmentKey {
    static let defaultValue = DefaultProseStyle.headingFont
}

private struct ProseLinkFontKey: EnvironmentKey {
    static let defaultValue = DefaultProseStyle.linkFont
}

private struct ProseParagraphLineSpacingKey: EnvironmentKey {
    static let defaultValue = DefaultProseStyle.paragraphLineSpacing
}

// MARK: EnvironmentValues
public extension EnvironmentValues {
    var proseNodeSpacing: CGFloat {
        get { self[ProseNodeSpacingKey.self] }
        set { self[ProseNodeSpacingKey.self] = newValue }
    }
    
    var proseTextColor: UIColor {
        get { self[ProseTextColorKey.self] }
        set { self[ProseTextColorKey.self] = newValue }
    }
    
    var proseHeadingTextColor: UIColor {
        get { self[ProseHeadingTextColorKey.self] }
        set { self[ProseHeadingTextColorKey.self] = newValue }
    }
    
    var proseLinkColor: UIColor {
        get { self[ProseLinkColorKey.self] }
        set { self[ProseLinkColorKey.self] = newValue }
    }
    
    var proseTextFont: UIFont {
        get { self[ProseTextFontKey.self] }
        set { self[ProseTextFontKey.self] = newValue }
    }
    
    var proseHeadingFont: UIFont {
        get { self[ProseHeadingFontKey.self] }
        set { self[ProseHeadingFontKey.self] = newValue }
    }
    
    var proseLinkFont: UIFont {
        get { self[ProseLinkFontKey.self] }
        set { self[ProseLinkFontKey.self] = newValue }
    }
    
    var proseParagraphLineSpacing: CGFloat {
        get { self[ProseParagraphLineSpacingKey.self] }
        set { self[ProseParagraphLineSpacingKey.self] = newValue }
    }
}

public extension View {
    func proseNodeSpacing(_ spacing: CGFloat) -> some View {
        environment(\.proseNodeSpacing, spacing)
    }
    
    func proseTextColor(_ color: UIColor) -> some View {
        environment(\.proseTextColor, color)
    }
    
    func proseHeadingTextColor(_ color: UIColor) -> some View {
        environment(\.proseHeadingTextColor, color)
    }

    func proseLinkColor(_ color: UIColor) -> some View {
        environment(\.proseLinkColor, color)
    }
    
    func proseTextFont(_ font: UIFont) -> some View {
        environment(\.proseTextFont, font)
    }
    
    func proseHeadingFont(_ font: UIFont) -> some View {
        environment(\.proseHeadingFont, font)
    }
    
    func proseLinkFont(_ font: UIFont) -> some View {
        environment(\.proseLinkFont, font)
    }
    
    func proseParagraphLineSpacing(_ spacing: CGFloat) -> some View {
        environment(\.proseParagraphLineSpacing, spacing)
    }
}
