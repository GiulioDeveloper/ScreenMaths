//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 20/10/20.
//

import Foundation

extension Expression {
    
    public static func ^ (_ lhs: Expression, _ rhs: Expression) -> Expression {
        if case costant(let rhsValue) = rhs {
            switch rhsValue {
            case 0:
                return .costant(1)
            case 1:
                return lhs
            default:
                if case costant(let lhsValue) = lhs  {
                    return .costant(lhsValue ^ rhsValue)
                }
            }
        }
        return exponential(base: lhs, exponent: rhs)
    }
    
}

