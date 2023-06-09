//
//  CustomBulletListStyles.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 01.04.23.
//

import SwiftyProse
import SwiftUI

public struct CustomBulletListStyle: BulletListStyle {
    public func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
            
            ForEach(configuration.content.indices, id: \.self) { i in
                let node = configuration.content[i]
                
                HStack(alignment: .firstTextBaseline) {
                    
                    Text(configuration.nestingLevel % 2 == 0 ? "👉" : "-")
                    
                    switch node {
                    case .listItem(let listItem):
                        listItem
                    default:
                        EmptyView()
                    }
                    
                }
            }
            
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.red)
        )
    }
}

public extension BulletListStyle where Self == CustomBulletListStyle {
    static var custom: Self { .init() }
}
