//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 08/09/20.
//

import Foundation

extension Expression {
    
    public static func * (_ lhs: Expression, _ rhs: Expression) -> Expression {
        switch lhs {
        case costant(let lhsValue):
            if lhsValue == 0 {
                return 0
            } else if lhsValue == 1 {
                return rhs
            }
            switch rhs {
            case costant(let rhsValue):
                return costant(lhsValue * rhsValue)
            case sum:
                return rhs * lhs
            case product(let rhsValues):
                var copy = rhsValues
                if let monomial = rhs.separateCoefficent() {
                    let newCoefficent = monomial.0 * lhsValue
                    copy[0] = .costant(newCoefficent)
                } else {
                    copy.insert(lhs, at: 0)
                }
                return .product(copy)
            case .fraction:
                return rhs * lhs
            default:
                return product([lhs, rhs])
            }
        case variable:
            switch rhs {
            case costant, fraction, product:
                return rhs * lhs
            case variable:
                if lhs == rhs {
                    return .exponential(base: lhs, exponent: .costant(2))
                } else {
                    return .product([lhs, rhs])
                }
            case .sum(let rhsValue):
                return sum(rhsValue.map({ $0 * lhs }))
            case .exponential(base: let base, exponent: let exponent):
                if base == lhs {
                    let newExponent = exponent + .costant(1)
                    return testExponent(newExponent, base: base)
                } else {
                    return product([lhs, rhs])
                }
            default:
                return product([lhs, rhs])
            }
        case sum:
            return .product([rhs, lhs])
        case product(let lhsValues):
            switch rhs {
            case .variable, .exponential:
                var copy = lhsValues
                for (index, element) in copy.enumerated() {
                    let test = element * rhs
                    if test == .costant(1) {
                        copy.remove(at: index)
                        return product(copy)
                    } else if case product = test {
                        continue
                    } else {
                        copy[index] = test
                        return product(copy)
                    }
                }
                return .product(lhsValues + [rhs])
            case .costant, .sum, fraction:
                return rhs * lhs
            case .product(let rhsValues):
                let sum = lhsValues.flatMap{ (lhsElement) in
                    rhsValues.map { $0 * lhsElement }
                }
                return sum.reduce(0, +)
            default:
                var copy = lhsValues
                copy.append(rhs)
                return product(copy)
            }
        case exponential(base: let lhsBase, exponent: let lhsExponent):
            switch rhs {
            case .variable, product, fraction, .costant:
                return rhs * lhs
            case .exponential(base: let rhsBase, exponent: let rhsExponent):
                if lhsBase == rhsBase {
                    let newExponent = lhsExponent + rhsExponent
                    return testExponent(newExponent, base: rhsBase)
                } else {
                    return product([lhs, rhs])
                }
            default:
                return product([lhs, rhs])
            }
        default:
            switch rhs {
            case sum, product:
                return rhs * lhs
            default:
                return .product([lhs, rhs])
            }
        }
    }
}
