//
//  TextNode.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import SwiftUI
import UIKit

/*
 group: inline
 content: -
*/
public struct TextNode {
    
    public var type: String = "text"
    public var text: String
    public var marks: [MarkType] = []
    
    public init(
        type: String = "text",
        text: String,
        marks: [MarkType] = [])
    {
        self.type = type
        self.text = text
        self.marks = marks
    }
}

// MARK: TextNode + Codable
extension TextNode: Codable {
    public enum CodingKeys: String, CodingKey {
        case type = "type"
        case text = "text"
        case marks = "marks"
    }
    
    public init(from decoder: Decoder) throws {
        self.type = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .type)
        self.text = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .text)
        self.marks = try decoder.container(keyedBy: CodingKeys.self).decodeIfPresent([MarkType].self, forKey: .marks) ?? []
    }
}

// MARK: TextNode + Equatable
extension TextNode: Equatable {
    public static func == (lhs: TextNode, rhs: TextNode) -> Bool {
        lhs.type == rhs.type &&
        lhs.text == rhs.text
    }
}

// MARK: TextNode + TextRenderable
extension TextNode: TextRenderable {
    public func attributedText(with font: UIFont, textColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        
        let range = NSRange(location: 0, length: attributedString.length)
        
        var font = font
        
        for mark in marks {

            switch mark {
            case .bold:
                font = font.bold()
            case .italic:
                font = font.italic()
            case .underline:
                attributedString.addAttributes([
                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                    .underlineColor: textColor
                ], range: range)
            case .strike:
                attributedString.addAttribute(
                    .strikethroughStyle,
                    value: NSUnderlineStyle.single.rawValue,
                    range: range)
            case .superscript:
                attributedString.addAttribute(
                    .baselineOffset,
                    value: 10,
                    range: range)
            case .link(let attrs):
                attributedString.addAttribute(
                    .link,
                    value: attrs?.href ?? "",
                    range: range)
            case .code:
                if let textColor = UIColor(hex: "#616161") {
                    attributedString.addAttributes([
                        .backgroundColor: textColor.withAlphaComponent(0.1),
                        .foregroundColor: textColor
                    ], range: range)
                }
            case .highlight(let attrs):
                guard let color = attrs?.color else {
                    attributedString.addAttribute(
                        .backgroundColor,
                        value: UIColor.systemYellow,
                        range: range)
                    break
                }
                if let htmlColor = HTMLColors(rawValue: color.lowercased())?.toUIColor {
                    attributedString.addAttribute(
                        .backgroundColor,
                        value: htmlColor,
                        range: range)
                } else if let hexColor = UIColor(hex: color) {
                    attributedString.addAttribute(
                        .backgroundColor,
                        value: hexColor,
                        range: range)
                } else {
                    attributedString.addAttribute(
                        .backgroundColor,
                        value: UIColor.systemYellow,
                        range: range)
                }
            }

        }
        attributedString.addAttributes([
            .font: font,
            .foregroundColor: textColor
        ], range: range)
        
        return attributedString
    }
}
