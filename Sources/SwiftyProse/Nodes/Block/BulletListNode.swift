//
//  BulletListNode.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import SwiftUI

/*
    group: block list
    content: listItem+
*/
public struct BulletListNode {
    
    @Environment(\.bulletListStyle) var style
    @Environment(\.relativeBulletListStyleNestingLevel) var nestingLevel
    
    public var type: String = "bulletList"
    public var content: [NodeWrapper] = []
    
    public init(
        type: String = "bulletList",
        content: [NodeWrapper])
    {
        self.type = type
        self.content = content
    }
}

// MARK: BulletListNode + Codable
extension BulletListNode: Codable {
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

// MARK: BulletListNode + Equatable
extension BulletListNode: Equatable {
    public static func == (
        lhs: BulletListNode,
        rhs: BulletListNode
    ) -> Bool {
        lhs.type == rhs.type &&
        lhs.content == rhs.content
    }
}

// MARK: BulletListNode + View
extension BulletListNode: View {
    public var body: some View {
        render()
    }
    
    @ViewBuilder
    public func render() -> some View {
        let configuration = BulletListStyleConfiguration(content: content, nestingLevel: nestingLevel)
        AnyView(style.resolve(configuration: configuration))
            .transformEnvironment(\.relativeBulletListStyleNestingLevel) { nestingLevel in
                nestingLevel += 1
            }
    }
}

// MARK: BulletListStyle
public protocol BulletListStyle: DynamicProperty {
    associatedtype Body: View

    typealias Configuration = BulletListStyleConfiguration
    
    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

public extension BulletListStyle {
    func resolve(configuration: Configuration) -> some View {
        ResolvedBulletListStyle(configuration: configuration, style: self)
    }
}

public struct ResolvedBulletListStyle<Style: BulletListStyle>: View {
    var configuration: Style.Configuration

    var style: Style

    public var body: Style.Body {
        style.makeBody(configuration: configuration)
    }
}

public struct BulletListStyleConfiguration {
    public let content: [NodeWrapper]
    public let nestingLevel: Int
    
    init(content: [NodeWrapper], nestingLevel: Int) {
        self.content = content
        self.nestingLevel = nestingLevel
    }
}

public struct BulletListStyleKey: EnvironmentKey {
    public static var defaultValue: any BulletListStyle = DefaultBulletListStyle()
}

public extension EnvironmentValues {
    var bulletListStyle: any BulletListStyle {
        get { self[BulletListStyleKey.self] }
        set { self[BulletListStyleKey.self] = newValue }
    }
}

public extension View {
    func bulletListStyle(_ style: some BulletListStyle) -> some View {
        environment(\.bulletListStyle, style)
    }
}

// MARK: DefaultBulletListStyle
public struct DefaultBulletListStyle: BulletListStyle {
    public func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
            
            ForEach(configuration.content.indices, id: \.self) { i in
             
                let node = configuration.content[i]
                
                HStack(alignment: .firstTextBaseline) {
                    
                    Text(configuration.nestingLevel % 2 == 0 ? "•" : "-")
                    
                    switch node {
                    case .listItem(let listItem):
                        listItem
                    default:
                        EmptyView()
                    }
                    
                }
                
            }
            
        }
    }
}

struct RelativeBulletListStyleNestingLevelKey: EnvironmentKey {
    static var defaultValue: Int = 0
}

public extension EnvironmentValues {
    var relativeBulletListStyleNestingLevel: Int {
        get { self[RelativeBulletListStyleNestingLevelKey.self] }
        set { self[RelativeBulletListStyleNestingLevelKey.self] = newValue }
    }
}
