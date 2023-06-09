//
//  DocNode.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import SwiftUI

/*
    group: -
    content: block+
*/
public struct DocNode {
    
    @Environment(\.proseLinkColor) var proseLinkColor
    @Environment(\.proseLinkFont) var proseLinkFont
    @Environment(\.proseNodeSpacing) var proseNodeSpacing
    @Environment(\.proseTextColor) var proseTextColor
    @Environment(\.proseTextFont) var proseTextFont
    
    public var type: String
    public var content: [NodeWrapper] = []
    
    public init(content: [NodeWrapper] = []) {
        self.type = "document"
        self.content = content
    } 
}

// MARK: DocNode + Codable
extension DocNode: Codable {
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

// MARK: DocNode + Equatable
extension DocNode: Equatable {
    public static func == (
        lhs: DocNode,
        rhs: DocNode
    ) -> Bool {
        lhs.type == rhs.type &&
        lhs.content == rhs.content
    }
}

// MARK: DocNode + View
extension DocNode: View {
    public var body: some View {
        render()
    }
    
    @ViewBuilder
    public func render() -> some View {
        VStack(spacing: proseNodeSpacing) {
            
            ForEach(content.indices, id: \.self) { i in
            
                let node = content[i]
                
                switch node {
                case .blockquote(let blockquote):
                    blockquote
                case .bulletList(let bulletList):
                    bulletList
                case .codeBlock(let codeBlock):
                    codeBlock
                case .hardBreak(let hardBreak):
                    TextView(.constant(hardBreak.attributedText(
                        with: proseTextFont, textColor: proseTextColor)))
                        .enableScrolling(false)
                case .heading(let heading):
                    heading
                case .horizontalRule(let horizontalRule):
                    horizontalRule
                case .listItem(let listItem):
                    listItem
                case .orderedList(let orderedList):
                    orderedList
                case .paragraph(let paragraph):
                    paragraph
                case .text(let text):
                    TextView(.constant(text.attributedText(
                        with: proseTextFont, textColor: proseTextColor)))
                        .enableScrolling(false)
                        .setLinkAttributes([
                            .foregroundColor: proseLinkColor,
                            .font: proseLinkFont
                        ])

                }
                
            }
            
        }
    }
}
