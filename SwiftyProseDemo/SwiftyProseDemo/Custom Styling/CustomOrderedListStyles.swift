//
//  CustomOrderedListNodes.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 01.04.23.
//

import SwiftyProse
import SwiftUI

public struct CustomOrderedListStyle: OrderedListStyle {
    
    let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    public func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
        
            ForEach(configuration.content.indices, id: \.self) { i in
                let node = configuration.content[i]
                
                HStack(alignment: .firstTextBaseline) {
                    
                    Text("\(String(alphabet[i])).")
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

public extension OrderedListStyle where Self == CustomOrderedListStyle {
    static var alphabetic: Self { .init() }
}
