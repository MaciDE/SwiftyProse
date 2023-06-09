//
//  SwiftyProseDecoder.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import Foundation

public class SwiftyProseDecoder {
    
    public enum DecodingError: LocalizedError {
        case stringEncodingFailed
    }
    
    private let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder = .defaultSwiftyProseDecoder) {
        self.decoder = decoder
    }
    
    public func decode(_ input: String) throws -> DocNode {
        guard let data = input.data(using: .utf8) else {
            throw DecodingError.stringEncodingFailed
        }
        
        return try decoder.decode(DocNode.self, from: data)
    }
}

public extension JSONDecoder {
    static let defaultSwiftyProseDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        return decoder
    }()
}
