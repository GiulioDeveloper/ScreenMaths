//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 11/09/20.
//

import Foundation

extension Expression {
    
    func separateCoefficent() -> (Int, [Expression])? {
        if case .product(let values) = self {
            if case .costant(let coefficent) = values.first! {
                var copy = values
                copy.removeFirst()
                return (coefficent, copy)
            } else {
                return (1, values)
            }
        } else {
            return nil
        }
    }
    
    var overallSign: Bool {
        switch self {
        case .sum(let values):
            var count = 0
            for value in values {
                count += value.overallSign ? 1 : -1
            }
            return count >= 0
        case .costant(let value):
            return value >= 0
        case .product:
            if let monomial = self.separateCoefficent() {
                return monomial.0 >= 0
            } else {
                return true
            }
        default:
            return true
        }
    }
    
    static func coefficentTest(_ coefficent: Int, otherResult: [Expression]) -> Expression {
        if coefficent == 0 {
            return 0
        } else if coefficent == 1 {
            guard otherResult.count != 1 else {
                return otherResult[0]
            }
            return .product(otherResult)
        } else {
            return .product([.costant(coefficent)] + otherResult)
        }
    }
    
    static func testExponent(_ exponent: Expression, base: Expression) -> Expression {
        if exponent == 0 {
            return 1
        } else if exponent == 1 {
            return base
        } else {
            return .exponential(base: base, exponent: exponent)
        }
    }
    
    var emptyChecked: Expression {
        if case .sum(let values) = self, values.count == 1 {
            return values[0]
        } else if case .product(let values) = self, values.count != 1 {
            return values[0]
        }
        return self
    }
    
    public var description: String {
        switch self {
        case .costant(let value):
            return String(value)
        case .variable(let value):
            return value.description
        case .sum(let values):
            var isFirst = true
            return values.reduce("") {
                if isFirst {
                    isFirst = false
                    return $1.description
                } else {
                    return $0 + " + " + $1.description
                }
            }
        case .product(let values):
            var isFirst = true
            return values.reduce("") {
                var valueDescription = $1.description
                if case Expression.sum = $1 {
                    valueDescription = "(" + valueDescription + ")"
                }
                if isFirst {
                    isFirst = false
                    return valueDescription
                } else {
                    return $0 + " * " + valueDescription
                }
            }
        case .fraction(num: let num, den: let den):
            return "(\(num.description))/(\(den.description))"
        case .exponential(base: let base, exponent: let exponent):
            return "(\(base.description))^(\(exponent.description))"
        case .logarithm(base: let base, argument: let argument):
            return "log(\(base.description) , \(argument.description))"
        case .root(base: let base, exponent: let exponent):
            return "root(\(base.description), \(exponent.description)"
        case .modulus(let argument):
            return "abs(\(argument.description))"
        case .cosine(let argument):
            return "cos(\(argument.description))"
        case .sine(let argument):
            return "sin(\(argument.description))"
        case .tangent(let argument):
            return "tan(\(argument.description))"
        }
    }
}
