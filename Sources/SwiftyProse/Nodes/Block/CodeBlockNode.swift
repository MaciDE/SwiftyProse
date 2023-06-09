//
//  CodeBlockNode.swift
//  
//
//  Created by Marcel Opitz on 02.04.23.
//

import SwiftUI

/*
    group: block
    content: text*
*/
public struct CodeBlockNode {
    
    @Environment(\.codeBlockStyle) var style
    
    public var type: String = "codeblock"
    public var content: [TextNode]
    
    public init(
        type: String = "codeblock",
        content: [TextNode])
    {
        self.type = type
        self.content = content
    }
}

// MARK: CodeBlockNode + View
extension CodeBlockNode: View {
    public var body: some View {
        render()
    }
    
    @ViewBuilder
    public func render() -> some View {
        let configuration = CodeBlockStyleConfiguration(
            content: content)
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: CodeBlockNode + Codable
extension CodeBlockNode: Codable {
    public enum CodingKeys: String, CodingKey {
        case type
        case content
    }
    
    public init(from decoder: Decoder) throws {
        type = try decoder.container(keyedBy: CodingKeys.self)
            .decode(String.self, forKey: .type)
        content = try decoder.container(keyedBy: CodingKeys.self)
            .decodeIfPresent([FailableDecodable<TextNode>].self, forKey: .content)?
            .compactMap({ $0.base }) ?? []
    }
}

// MARK: CodeBlockNode + Equatable
extension CodeBlockNode: Equatable {
    public static func == (
        lhs: CodeBlockNode,
        rhs: CodeBlockNode
    ) -> Bool {
        lhs.type == rhs.type &&
        lhs.content == rhs.content
    }
}

// MARK: CodeBlockStyle
public protocol CodeBlockStyle: DynamicProperty {
    associatedtype Body: View

    @ViewBuilder func makeBody(configuration: Configuration) -> Body

    typealias Configuration = CodeBlockStyleConfiguration
}

public extension CodeBlockStyle {
    func resolve(configuration: Configuration) -> some View {
        ResolvedCodeBlockStyle(configuration: configuration, style: self)
    }
}

public struct ResolvedCodeBlockStyle<Style: CodeBlockStyle>: View {
    var configuration: Style.Configuration

    var style: Style

    public var body: Style.Body {
        style.makeBody(configuration: configuration)
    }
}

public struct CodeBlockStyleConfiguration {
    public let content: [TextNode]
    
    init(content: [TextNode]) {
        self.content = content
    }
}

public struct CodeBlockStyleKey: EnvironmentKey {
    public static var defaultValue: any CodeBlockStyle = DefaultCodeBlockStyle()
}

public extension EnvironmentValues {
    var codeBlockStyle: any CodeBlockStyle {
        get { self[CodeBlockStyleKey.self] }
        set { self[CodeBlockStyleKey.self] = newValue }
    }
}

public extension View {
    func codeBlockStyle(_ style: some CodeBlockStyle) -> some View {
        environment(\.codeBlockStyle, style)
    }
}

// MARK: DefaultCodeBlockStyle
public struct DefaultCodeBlockStyle: CodeBlockStyle {
    public func makeBody(configuration: Configuration) -> some View {
        TextView(.constant(buildAttributedString(from: configuration.content)))
            .enableScrolling(false)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(UIColor.darkGray))
            )
    }
    
    private func buildAttributedString(from nodes: [TextNode]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(
            attributedString: nodes.reducedAttributedString(
                with: .monospacedSystemFont(ofSize: 12.0, weight: .regular),
                textColor: UIColor.white))
        return attributedString
    }
}
