//
//  CustomHorizontalRuleStyles.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 01.04.23.
//

import SwiftyProse
import SwiftUI

public struct Custom1HorizontalRuleStyle: HorizontalRuleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        Rectangle()
            .foregroundColor(.red)
            .frame(height: 10)
    }
}

public extension HorizontalRuleStyle where Self == Custom1HorizontalRuleStyle {
    static var custom1: Self { .init() }
}

public struct Custom2HorizontalRuleStyle: HorizontalRuleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        Text("👻👻👻👻👻👻👻👻👻👻👻👻👻👻👻👻")
            .frame(height: 10)
    }
}

public extension HorizontalRuleStyle where Self == Custom2HorizontalRuleStyle {
    static var custom2: Self { .init() }
}
