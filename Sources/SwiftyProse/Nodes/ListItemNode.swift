//
//  ListItemNode.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import Foundation
import SwiftUI

/*
 group: -
 content: paragraph block*
*/
public struct ListItemNode {
    
    public var type: String = "listItem"
    public var content: [NodeWrapper]
    
    public init(
        type: String = "listItem",
        content: [NodeWrapper]
    ) {
        self.type = type
        self.content = content
    }
}

// MARK: ListItemNode + Codable
extension ListItemNode: Codable {
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

// MARK: ListItemNode + Equatable
extension ListItemNode: Equatable {
    public static func == (lhs: ListItemNode, rhs: ListItemNode) -> Bool {
        lhs.type == rhs.type &&
        lhs.content == rhs.content
    }
}

// MARK: ListItemNode + View
extension ListItemNode: View {
    public var body: some View {
        render()
    }
    
    @ViewBuilder
    public func render() -> some View {
        VStack {
            
            ForEach(content.indices, id: \.self) { i in
                let node = content[i]
                switch node {
                case .blockquote(let blockquote):
                    blockquote
                case .bulletList(let bullestList):
                    bullestList
                case .codeBlock(let codeBlock):
                    codeBlock
                case .heading(let heading):
                    heading
                case .horizontalRule(let horizontalRule):
                    horizontalRule
                case .paragraph(let paragraph):
                    paragraph
                case .orderedList(let orderedList):
                    orderedList
                default:
                    EmptyView()
                }
            }
            
        }
    }
}
