//
//  Node.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import Foundation

// Wraps a node, primarly used for decoding
public enum NodeWrapper: Equatable {
    case blockquote(BlockquoteNode)
    case bulletList(BulletListNode)
    case codeBlock(CodeBlockNode)
    case hardBreak(HardBreakNode)
    case heading(HeadingNode)
    case horizontalRule(HorizontalRuleNode)
    case listItem(ListItemNode)
    case orderedList(OrderedListNode)
    case paragraph(ParagraphNode)
    case text(TextNode)
}

// MARK: NodeWrapper + Codable
extension NodeWrapper: Codable {
    private enum CodingKeys: String, CodingKey {
        case type = "type"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let singleContainer = try decoder.singleValueContainer()
        
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "blockquote":
            let blockquote = try singleContainer.decode(BlockquoteNode.self)
            self = .blockquote(blockquote)
        case "bulletList", "bullet_list":
            let bulletList = try singleContainer.decode(BulletListNode.self)
            self = .bulletList(bulletList)
        case "codeBlock", "code_block":
            let codeBlock = try singleContainer.decode(CodeBlockNode.self)
            self = .codeBlock(codeBlock)
        case "hardBreak", "hard_break":
            let hardBreak = try singleContainer.decode(HardBreakNode.self)
            self = .hardBreak(hardBreak)
        case "heading":
            let heading = try singleContainer.decode(HeadingNode.self)
            self = .heading(heading)
        case "horizontalRule", "horizontal_rule":
            let horizontalRule = try singleContainer.decode(HorizontalRuleNode.self)
            self = .horizontalRule(horizontalRule)
        case "listItem", "list_item":
            let listItem = try singleContainer.decode(ListItemNode.self)
            self = .listItem(listItem)
        case "orderedList", "ordered_list":
            let orderedList = try singleContainer.decode(OrderedListNode.self)
            self = .orderedList(orderedList)
        case "paragraph":
            let paragraph = try singleContainer.decode(ParagraphNode.self)
            self = .paragraph(paragraph)
        case "text":
            let text = try singleContainer.decode(TextNode.self)
            self = .text(text)
        default:
            NSLog("Unknown type of content.")
            throw SwiftyProseError.unknownNodeType(type: type)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var singleContainer = encoder.singleValueContainer()
        
        switch self {
        case .blockquote(let blockquote):
            try singleContainer.encode(blockquote)
        case .bulletList(let bulletList):
            try singleContainer.encode(bulletList)
        case .codeBlock(let codeBlock):
            try singleContainer.encode(codeBlock)
        case .hardBreak(let hardBreak):
            try singleContainer.encode(hardBreak)
        case .heading(let heading):
            try singleContainer.encode(heading)
        case .horizontalRule(let horizontalRule):
            try singleContainer.encode(horizontalRule)
        case .listItem(let listItem):
            try singleContainer.encode(listItem)
        case .orderedList(let orderedList):
            try singleContainer.encode(orderedList)
        case .paragraph(let paragraph):
            try singleContainer.encode(paragraph)
        case .text(let text):
            try singleContainer.encode(text)
        }
    }
}
