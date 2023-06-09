//
//  SwiftyProseError.swift
//  SwiftyProse
//
//  Created by Marcel Opitz on 17.09.21.
//

import Foundation

enum SwiftyProseError: Error {
    case unknownNodeType(type: String)
    case unknownMarkType(type: String)
}
