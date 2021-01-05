//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 12/11/20.
//

import Foundation

public enum Container: CustomStringConvertible {
    
    case expression(Expression)
    case equation(left: Expression, right: Expression)
    
    public var description: String {
        switch self {
        case .expression(let value):
            return value.description
        case .equation(left: let left, right: let right):
            return left.description + " = " + right.description
        }
    }
    
    @discardableResult
    public func generateBuffer(in set: RSet) -> RSet {
        switch self {
        case .expression(let value):
            return value.generateBuffer(in: set)
        case .equation(left: let left, right: let right):
            left.generateBuffer(in: set)
            set.add(key: MathKey.equalSign, at: set.keys.count)
            right.generateBuffer(in: set)
            return set
        }
    }
    
}
