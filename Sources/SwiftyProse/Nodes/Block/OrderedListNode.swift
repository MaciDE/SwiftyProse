//
//  OrderedListNode.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import SwiftUI

/*
    group: block list
    content: listItem+
*/
public struct OrderedListNode {
    
    @Environment(\.orderedListStyle) var style
    @Environment(\.relativeOrderedlistStyleNestingLevel) var nestingLevel
    
    @State private var width: CGFloat? = nil
    
    public var type: String = "orderedList"
    public var content: [NodeWrapper] = []
    
    public init(
        type: String = "orderedList",
        content: [NodeWrapper]
    ) {
        self.type = type
        self.content = content
    }
    
}

// MARK: OrderedListNode + Codable
extension OrderedListNode: Codable {
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

// MARK: OrderedListNode + Equatable
extension OrderedListNode: Equatable {
    public static func == (
        lhs: OrderedListNode,
        rhs: OrderedListNode
    ) -> Bool {
        lhs.type == rhs.type &&
        lhs.content == rhs.content
    }
}

// MARK: OrderedListNode + View
extension OrderedListNode: View {
    public var body: some View {
        render()
    }
    
    @ViewBuilder
    public func render() -> some View {
        let configuration = OrderedListStyleConfiguration(
            content: content,
            nestingLevel: nestingLevel,
            counterWidth: width)
        AnyView(style.resolve(configuration: configuration))
            .transformEnvironment(\.relativeOrderedlistStyleNestingLevel) { nestingLevel in
                nestingLevel += 1
            }
            .onPreferenceChange(WidthPreferenceKey.self) { widths in
                if let width = widths.max() {
                    self.width = width
                }
            }
    }
}

// MARK: OrderedListStyle
public protocol OrderedListStyle: DynamicProperty {
    associatedtype Body: View

    typealias Configuration = OrderedListStyleConfiguration
    
    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

public extension OrderedListStyle {
    func resolve(configuration: Configuration) -> some View {
        ResolvedOrderedListStyle(configuration: configuration, style: self)
    }
}

public struct ResolvedOrderedListStyle<Style: OrderedListStyle>: View {
    var configuration: Style.Configuration

    var style: Style

    public var body: Style.Body {
        style.makeBody(configuration: configuration)
    }
}

public struct OrderedListStyleConfiguration {
    public let content: [NodeWrapper]
    public let nestingLevel: Int
    public let counterWidth: CGFloat?
    
    init(content: [NodeWrapper], nestingLevel: Int, counterWidth: CGFloat?) {
        self.content = content
        self.nestingLevel = nestingLevel
        self.counterWidth = counterWidth
    }
}

public struct OrderedListStyleKey: EnvironmentKey {
    public static var defaultValue: any OrderedListStyle = DefaultOrderedListStyle()
}

public extension EnvironmentValues {
    var orderedListStyle: any OrderedListStyle {
        get { self[OrderedListStyleKey.self] }
        set { self[OrderedListStyleKey.self] = newValue }
    }
}

public extension View {
    func orderedListStyle(_ style: some OrderedListStyle) -> some View {
        environment(\.orderedListStyle, style)
    }
}

// MARK: DefaultOrderedListStyle
public struct DefaultOrderedListStyle: OrderedListStyle {
    public func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
        
            ForEach(configuration.content.indices, id: \.self) { i in
             
                let node = configuration.content[i]
                
                HStack(alignment: .firstTextBaseline) {
                    
                    Text("\(i+1).")
                        .equalWidth()
                        .frame(width: configuration.counterWidth, alignment: .leading)
                    
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

struct RelativeOrderedlistStyleNestingLevelKey: EnvironmentKey {
    static var defaultValue: Int = 0
}

public extension EnvironmentValues {
    var relativeOrderedlistStyleNestingLevel: Int {
        get { self[RelativeOrderedlistStyleNestingLevelKey.self] }
        set { self[RelativeOrderedlistStyleNestingLevelKey.self] = newValue }
    }
}
