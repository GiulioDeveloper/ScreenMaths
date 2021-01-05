//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 09/09/20.
//

import Foundation

extension Expression: SignedNumeric {
    
    public static func - (lhs: Expression, rhs: Expression) -> Expression {
        lhs + (-1 * rhs)
    }
    
    
    public typealias Magnitude = Int
    
    public typealias IntegerLiteralType = Int
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        self = .costant(Int(source))
    }
    
    public var magnitude: Int {
        return 0 //TODO: Vedere a cosa può servire
    }
    
    public static func *= (lhs: inout Expression, rhs: Expression) {
        lhs = lhs * rhs
    }
    
    public init(integerLiteral value: Int) {
        self = .costant(value)
    }
    
}
