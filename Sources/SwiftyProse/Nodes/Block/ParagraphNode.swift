//
//  ParagraphNode.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import SwiftUI

/*
    group: block
    content: inline*
*/
public struct ParagraphNode {

    @Environment(\.paragraphStyle) var style

    public var type: String = "paragraph"
    public var content: [NodeWrapper]
    
    public init(
        type: String = "paragraph",
        content: [NodeWrapper] = []
    ) {
        self.type = type
        self.content = content
    }
}

// MARK: ParagraphNode + Codable
extension ParagraphNode: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case content
    }
    
    public init(from decoder: Decoder) throws {
        type = try decoder.container(keyedBy: CodingKeys.self)
            .decode(String.self, forKey: .type)
        content = try decoder.container(keyedBy: CodingKeys.self)
            .decodeIfPresent([FailableDecodable<NodeWrapper>].self, forKey: .content)?
            .compactMap({ $0.base }) ?? []
    }
}

// MARK: ParagraphNode + Equatable
extension ParagraphNode: Equatable {
    public static func == (
        lhs: ParagraphNode,
        rhs: ParagraphNode
    ) -> Bool {
        lhs.type == rhs.type &&
        lhs.content == rhs.content
    }
}

// MARK: ParagraphNode + View
extension ParagraphNode: View {
    public var body: some View {
        render()
    }
    
    @ViewBuilder
    public func render() -> some View {
        let configuration = ParagraphStyleConfiguration(content: content)
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: ParagraphStyle
public protocol ParagraphStyle: DynamicProperty {
    associatedtype Body: View

    typealias Configuration = ParagraphStyleConfiguration
    
    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

public extension ParagraphStyle {
    func resolve(configuration: Configuration) -> some View {
        ResolvedParagraphStyle(configuration: configuration, style: self)
    }
}

public struct ResolvedParagraphStyle<Style: ParagraphStyle>: View {
    var configuration: Style.Configuration

    var style: Style

    public var body: Style.Body {
        style.makeBody(configuration: configuration)
    }
}

public struct ParagraphStyleConfiguration {
    public let content: [NodeWrapper]
    
    init(content: [NodeWrapper]) {
        self.content = content
    }
}

public struct ParagraphStyleKey: EnvironmentKey {
    public static var defaultValue: any ParagraphStyle = DefaultParagraphStyle()
}

public extension EnvironmentValues {
    var paragraphStyle: any ParagraphStyle {
        get { self[ParagraphStyleKey.self] }
        set { self[ParagraphStyleKey.self] = newValue }
    }
}

public extension View {
    func paragraphStyle(_ style: some ParagraphStyle) -> some View {
        environment(\.paragraphStyle, style)
    }
}

// MARK: DefaultParagraphStyle
public struct DefaultParagraphStyle: ParagraphStyle {
    
    @Environment(\.proseLinkColor) var proseLinkColor
    @Environment(\.proseLinkFont) var proseLinkFont
    @Environment(\.proseParagraphLineSpacing) var proseParagraphLineSpacing
    @Environment(\.proseTextColor) var proseTextColor
    @Environment(\.proseTextFont) var proseTextFont
    
    public func makeBody(configuration: Configuration) -> some View {
        TextView(.constant(buildAttributedString(from: configuration.content)))
            .enableScrolling(false)
            .setLinkAttributes([
                .foregroundColor: proseLinkColor,
                .font: proseLinkFont
            ])
    }
    
    private func buildAttributedString(from nodes: [NodeWrapper]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(
            attributedString: nodes.reducedAttributedString(
                with: proseTextFont, textColor: proseTextColor))
        
        let range = NSRange(location: 0, length: attributedString.length)
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = proseParagraphLineSpacing
        
        attributedString.addAttributes([
            NSAttributedString.Key.paragraphStyle: paragraph,
        ], range: range)
        return attributedString
    }
}
