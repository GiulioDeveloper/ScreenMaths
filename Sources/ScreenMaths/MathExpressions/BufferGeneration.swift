//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 12/11/20.
//

import Foundation

extension Expression {
    
    @discardableResult
    public func generateBuffer(in set: RSet) -> RSet {
        switch self {
        case .costant(let number):
            for digit in abs(number).digits {
                if number < 0 {
                    set.add(key: MathKey.minus, at: set.lastIndex)
                }
                set.add(key: MathKey.digit(digit), at: set.lastIndex)
            }
        case .variable(let symbol):
            set.add(key: MathKey.variable(symbol), at: set.lastIndex)
        case .sum(let values):
            for (index, value) in values.enumerated() {
                if index == 0 {
                    value.generateBuffer(in: set)
                } else {
                    set.add(key: MathKey.plus, at: set.lastIndex)
                    value.generateBuffer(in: set)
                }
            }
        case .product(let values):
            for value in values {
                value.generateBuffer(in: set)
            }
        case .fraction(num: let num, den: let den):
            let numSet = RSet()
            let denSet = RSet()
            set.add(group: GroupKey(mode: .fraction), with: [num.generateBuffer(in: numSet), den.generateBuffer(in: denSet)], at: set.lastIndex)
        case .exponential(base: let base, exponent: let exponent):
            let baseSet = RSet()
            let exponentSet = RSet()
            set.add(group: GroupKey(mode: .exponent), with: [base.generateBuffer(in: baseSet), exponent.generateBuffer(in: exponentSet)], at: set.lastIndex)
        case .logarithm(base: let base, argument: let argument):
            let baseSet = RSet()
            let argumentSet = RSet()
            set.add(group: GroupKey(mode: .logarithm), with: [base.generateBuffer(in: baseSet), argument.generateBuffer(in: argumentSet)], at: set.lastIndex)
        case .root(base: let base, exponent: let exponent):
            let baseSet = RSet()
            let exponentSet = RSet()
            set.add(group: GroupKey(mode: .root), with: [base.generateBuffer(in: baseSet), exponent.generateBuffer(in: exponentSet)], at: set.lastIndex)
        case .modulus(let argument):
            let argumentSet = RSet()
            set.add(group: GroupKey(mode: .modulus), with: [argument.generateBuffer(in: argumentSet)], at: set.lastIndex) //Da cambiare
        case .cosine(let argument):
            let argumentSet = RSet()
            set.add(group: GroupKey(mode: .unOperation("cos")), with: [argument.generateBuffer(in: argumentSet)], at: set.lastIndex)
        case .sine(let argument):
            let argumentSet = RSet()
            set.add(group: GroupKey(mode: .unOperation("sin")), with: [argument.generateBuffer(in: argumentSet)], at: set.lastIndex)
        case .tangent(let argument):
            let argumentSet = RSet()
            set.add(group: GroupKey(mode: .unOperation("tan")), with: [argument.generateBuffer(in: argumentSet)], at: set.lastIndex)
        }
        
        return set
    }
    
}
