//
//  MarkType.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import Foundation

public struct MarkLinkAttributes: Codable, Equatable {
    public var href: String
}

public struct MarkHighlightAttributes: Codable, Equatable {
    public var color: String
}

public enum MarkType: Equatable {
    case bold
    case code
    case highlight(attrs: MarkHighlightAttributes?)
    case italic
    case link(attrs: MarkLinkAttributes?)
    case strike
    //    case `subscript` = "subscript"
    case superscript
    case underline
}

// MARK: MarkType + Codable
extension MarkType: Codable {
    public init(from decoder: Decoder) throws {
        let type = try decoder.container(keyedBy: CodingKeys.self)
            .decode(String.self, forKey: .type)
        
        switch type {
        case MarkType.bold.rawValue:
            self = .bold
        case MarkType.code.rawValue:
            self = .code
        case "highlight":
            let attrs = try decoder.container(keyedBy: CodingKeys.self)
                .decodeIfPresent(MarkHighlightAttributes.self, forKey: .attrs)
            self = .highlight(attrs: attrs)
        case MarkType.italic.rawValue:
            self = .italic
        case "link":
            let attrs = try decoder.container(keyedBy: CodingKeys.self)
                .decodeIfPresent(MarkLinkAttributes.self, forKey: .attrs)
            self = .link(attrs: attrs)
        case MarkType.strike.rawValue:
            self = .strike
        case MarkType.superscript.rawValue:
            self = .superscript
        case MarkType.underline.rawValue:
            self = .underline
        default:
            throw SwiftyProseError.unknownMarkType(type: type)
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
            case .link(let attrs):
                try container.encodeIfPresent(attrs, forKey: .attrs)
            case .highlight(let attrs):
                try container.encodeIfPresent(attrs, forKey: .attrs)
            default:
                try container.encode(self.rawValue, forKey: .type)
        }
    }
    
    public enum CodingKeys: String, CodingKey {
        case type = "type"
        case attrs = "attrs"
    }
    
    public var rawValue: String {
        switch self {
        case .bold:
            return "bold"
        case .code:
            return "code"
        case .highlight:
            return "highlight"
        case .italic:
            return "italic"
        case .link:
            return "link"
        case .strike:
            return "strike"
        case .superscript:
            return "superscript"
        case .underline:
            return "underline"
        }
    }
}
