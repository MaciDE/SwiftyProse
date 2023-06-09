//
//  BlockquoteNode.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import SwiftUI

/*
    group: block
    content: block*
*/
public struct BlockquoteNode {
    
    @Environment(\.blockquoteStyle) var style
    
    public var type: String = "blockquote"
    public var content: [NodeWrapper]
    
    public init(
        type: String = "blockquote",
        content: [NodeWrapper])
    {
        self.type = type
        self.content = content
    }
}

// MARK: BlockquoteNode + Codable
extension BlockquoteNode: Codable {
    public enum CodingKeys: String, CodingKey {
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

// MARK: BlockquoteNode + Equatable
extension BlockquoteNode: Equatable {
    public static func == (
        lhs: BlockquoteNode,
        rhs: BlockquoteNode
    ) -> Bool {
        lhs.type == rhs.type &&
        lhs.content == rhs.content
    }
}

// MARK: BlockquoteNode + View
extension BlockquoteNode: View {
    public var body: some View {
        render()
    }
    
    @ViewBuilder
    public func render() -> some View {
        let configuration = BlockquoteStyleConfiguration(content: content)
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: BlockquoteStyle
public protocol BlockquoteStyle: DynamicProperty {
    associatedtype Body: View

    @ViewBuilder func makeBody(configuration: Configuration) -> Body

    typealias Configuration = BlockquoteStyleConfiguration
}

public extension BlockquoteStyle {
    func resolve(configuration: Configuration) -> some View {
        ResolvedBlockquoteStyle(configuration: configuration, style: self)
    }
}

public struct ResolvedBlockquoteStyle<Style: BlockquoteStyle>: View {
    var configuration: Style.Configuration

    var style: Style

    public var body: Style.Body {
        style.makeBody(configuration: configuration)
    }
}

public struct BlockquoteStyleConfiguration {
    public let content: [NodeWrapper]
    
    init(content: [NodeWrapper]) {
        self.content = content
    }
}

public struct BlockquoteStyleKey: EnvironmentKey {
    public static var defaultValue: any BlockquoteStyle = DefaultBlockquoteStyle()
}

public extension EnvironmentValues {
    var blockquoteStyle: any BlockquoteStyle {
        get { self[BlockquoteStyleKey.self] }
        set { self[BlockquoteStyleKey.self] = newValue }
    }
}

public extension View {
    func blockquoteStyle(_ style: some BlockquoteStyle) -> some View {
        environment(\.blockquoteStyle, style)
    }
}

// MARK: DefaultBlockquoteStyle
public struct DefaultBlockquoteStyle: BlockquoteStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            
            Rectangle()
                .frame(width: 3)
                .foregroundColor(.gray)
                
            VStack {
                
                ForEach(configuration.content.indices, id: \.self) { i in
                    
                    let node = configuration.content[i]
                    
                    switch node {
                    case .paragraph(let paragraph):
                        paragraph
                    case .heading(let heading):
                        heading
                    case .blockquote(let blockquote):
                        blockquote
                    case .horizontalRule(let horizontalRule):
                        horizontalRule
                    case .bulletList(let bullestList):
                        bullestList
                    case .orderedList(let orderedList):
                        orderedList
                    default:
                        EmptyView()
                    }
                    
                    
                }
                
            }
            
        }.padding(.horizontal)
    }
}
