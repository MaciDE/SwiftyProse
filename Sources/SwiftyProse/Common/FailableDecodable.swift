//
//  FailableDecodable.swift
//  
//
//  Created by Marcel Opitz on 09.11.21.
//

import Foundation

internal struct FailableDecodable<Base: Decodable>: Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}
