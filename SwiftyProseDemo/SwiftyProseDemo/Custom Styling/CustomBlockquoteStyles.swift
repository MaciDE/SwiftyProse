//
//  CustomBlockquoteStyles.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 01.04.23.
//

import SwiftyProse
import SwiftUI

public struct CustomBlockquoteStyle: BlockquoteStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top) {
            
            Text("”")
                .font(.headline)
                
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

public extension BlockquoteStyle where Self == CustomBlockquoteStyle {
    static var custom: Self { .init() }
}
