//
//  HeadingNode.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import SwiftUI

public struct HeadingAttributes: Codable, Equatable {
    public var level: Int = 1
    
    public init(level: Int = 1) {
        self.level = level
    }
}

/*
    group: block
    content: inline*
*/
public struct HeadingNode {
    
    @Environment(\.headingStyle) var style
    
    public var type: String = "heading"
    public var content: [NodeWrapper] = []
    public var attrs: HeadingAttributes?
    
    public init(
        type: String = "heading",
        content: [NodeWrapper] = [],
        attrs: HeadingAttributes? = nil
    ) {
        self.type = type
        self.content = content
        self.attrs = attrs
    }
}

// MARK: HeadingNode + Codable
extension HeadingNode: Codable {
    public enum CodingKeys: String, CodingKey {
        case type
        case content
        case attrs
    }
    
    public init(from decoder: Decoder) throws {
        type = try decoder.container(keyedBy: CodingKeys.self)
            .decode(String.self, forKey: .type)
        content = try decoder.container(keyedBy: CodingKeys.self)
            .decodeIfPresent([FailableDecodable<NodeWrapper>].self, forKey: .content)?
            .compactMap({ $0.base }) ?? []
        attrs = try? decoder.container(keyedBy: CodingKeys.self)
            .decode(HeadingAttributes.self, forKey: .attrs)
    }
}

// MARK: HeadingNode + Equatable
extension HeadingNode: Equatable {
    public static func == (
        lhs: HeadingNode,
        rhs: HeadingNode
    ) -> Bool {
        lhs.type == rhs.type &&
        lhs.content == rhs.content
    }
}

// MARK: HeadingNode + View
extension HeadingNode: View {
    public var body: some View {
        render()
    }
    
    @ViewBuilder
    public func render() -> some View {
        let configuration = HeadingStyleConfiguration(content: content, attributes: attrs)
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: HeadingStyle
public protocol HeadingStyle: DynamicProperty {
    associatedtype Body: View

    typealias Configuration = HeadingStyleConfiguration
    
    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

public extension HeadingStyle {
    func resolve(configuration: Configuration) -> some View {
        ResolvedHeadingStyle(configuration: configuration, style: self)
    }
}

public struct ResolvedHeadingStyle<Style: HeadingStyle>: View {
    var configuration: Style.Configuration

    var style: Style

    public var body: Style.Body {
        style.makeBody(configuration: configuration)
    }
}

public struct HeadingStyleConfiguration {
    public let content: [NodeWrapper]
    public let attributes: HeadingAttributes?
    
    init(content: [NodeWrapper], attributes: HeadingAttributes?) {
        self.content = content
        self.attributes = attributes
    }
}

public struct HeadingStyleKey: EnvironmentKey {
    public static var defaultValue: any HeadingStyle = DefaultHeadingStyle()
}

public extension EnvironmentValues {
    var headingStyle: any HeadingStyle {
        get { self[HeadingStyleKey.self] }
        set { self[HeadingStyleKey.self] = newValue }
    }
}

public extension View {
    func headingStyle(_ style: some HeadingStyle) -> some View {
        environment(\.headingStyle, style)
    }
}

// MARK: DefaultHeadingStyle
public struct DefaultHeadingStyle: HeadingStyle {
    
    @Environment(\.proseLinkColor) var proseLinkColor
    @Environment(\.proseLinkFont) var proseLinkFont
    @Environment(\.proseHeadingTextColor) var proseHeadingTextColor
    @Environment(\.proseHeadingFont) var proseHeadingFont
    
    public func makeBody(configuration: Configuration) -> some View {
        TextView(.constant(
            buildAttributedString(
                from: configuration.content,
                attributes: configuration.attributes)))
                    .enableScrolling(false)
                    .setLinkAttributes([
                        .foregroundColor: proseLinkColor,
                        .font: proseLinkFont
                    ])
    }
    
    private func buildAttributedString(
        from nodes: [NodeWrapper],
        attributes: HeadingAttributes?)
    -> NSAttributedString {
        let attributedString = NSMutableAttributedString(
            attributedString: nodes.reducedAttributedString(
                with: proseHeadingFont, textColor: proseHeadingTextColor))
        
        guard let attributes else { return attributedString }
        
        var font = proseHeadingFont
        
        switch attributes.level {
        case 1:
            font = font.withSize(32)
        case 2:
            font = font.withSize(24)
        case 3:
            font = font.withSize(19)
        case 4:
            font = font.withSize(16)
        case 5:
            font = font.withSize(14)
        case 6:
            font = font.withSize(13)
        default:
            break
        }
        
        attributedString.setFont(font)
        
        return attributedString
    }
}
