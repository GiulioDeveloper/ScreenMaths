//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 06/09/20.
//

import Foundation

public struct Symbol: Hashable, Codable, CustomStringConvertible {
    
    var name: String
    var kind: String
    
    public var description: String {
        if kind == "" {
            return name
        } else {
            return name + "_" + kind
        }
    }
    
    public init(_ name: String, kind: String = "") {
        self.name = name
        self.kind = kind
    }
    
    public static let e = Symbol("e")
    
}
