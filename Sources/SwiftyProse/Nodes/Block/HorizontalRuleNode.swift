//
//  HorizontalRuleNode.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import SwiftUI

/*
    group: block
    content: -
*/
public struct HorizontalRuleNode {
    
    @Environment(\.horizontalRuleStyle) var style
    
    public var type: String = "horizontalRule"
    
    public init(type: String = "horizontalRule") {
        self.type = type
    }
}

// MARK: HorizontalRuleNode + View
extension HorizontalRuleNode: View {
    public var body: some View {
        render()
    }
    
    @ViewBuilder
    public func render() -> some View {
        let configuration = HorizontalRuleStyleConfiguration()
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: HorizontalRuleNode + Codable
extension HorizontalRuleNode: Codable {
    public enum CodingKeys: String, CodingKey {
        case type
    }
}

// MARK: HorizontalRuleNode + Equatable
extension HorizontalRuleNode: Equatable {
    public static func == (
        lhs: HorizontalRuleNode,
        rhs: HorizontalRuleNode
    ) -> Bool {
        lhs.type == rhs.type
    }
}

// MARK: HorizontalRuleStyle
public protocol HorizontalRuleStyle: DynamicProperty {
    associatedtype Body: View

    @ViewBuilder func makeBody(configuration: Configuration) -> Body

    typealias Configuration = HorizontalRuleStyleConfiguration
}

public extension HorizontalRuleStyle {
    func resolve(configuration: Configuration) -> some View {
        ResolvedHorizontalRuleStyle(configuration: configuration, style: self)
    }
}

public struct ResolvedHorizontalRuleStyle<Style: HorizontalRuleStyle>: View {
    var configuration: Style.Configuration

    var style: Style

    public var body: Style.Body {
        style.makeBody(configuration: configuration)
    }
}

public struct HorizontalRuleStyleConfiguration { }

public struct HorizontalRuleStyleKey: EnvironmentKey {
    public static var defaultValue: any HorizontalRuleStyle = DefaultHorizontalRuleStyle()
}

public extension EnvironmentValues {
    var horizontalRuleStyle: any HorizontalRuleStyle {
        get { self[HorizontalRuleStyleKey.self] }
        set { self[HorizontalRuleStyleKey.self] = newValue }
    }
}

public extension View {
    func horizontalRuleStyle(_ style: some HorizontalRuleStyle) -> some View {
        environment(\.horizontalRuleStyle, style)
    }
}

// MARK: DefaultHorizontalRuleStyle
public struct DefaultHorizontalRuleStyle: HorizontalRuleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        Rectangle()
            .foregroundColor(.gray)
            .frame(height: 1)
    }
}
