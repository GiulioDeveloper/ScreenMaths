//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 17/08/20.
//

import Foundation

public indirect enum Expression: Hashable, CustomStringConvertible {
    
    case costant(Int)
    case variable(Symbol)
    case sum([Expression])
    case product([Expression])
    case fraction(num: Expression, den: Expression)
    case exponential(base: Expression, exponent: Expression)
    case logarithm(base: Expression, argument: Expression)
    case root(base: Expression, exponent: Expression)
    case modulus(Expression)
    case cosine(Expression)
    case sine(Expression)
    case tangent(Expression)
    
}
