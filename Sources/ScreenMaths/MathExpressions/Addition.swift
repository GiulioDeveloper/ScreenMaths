//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 08/09/20.
//

import Foundation

extension Expression {
    
    public static func + (_ lhs: Expression, _ rhs: Expression) -> Expression {
        switch lhs {
        case .costant(let lhsValue):
            if lhsValue == 0 {
                return rhs
            }
            switch rhs {
            case .costant(let rhsValue):
                return .costant(lhsValue + rhsValue)
            case .sum:
                return rhs + lhs
            default:
                return .sum([rhs, lhs])
            }
        case .sum(let lhsValue):
            switch rhs {
            case .sum(let rhsValues):
                return rhsValues.reduce(into: lhs) { (acc, current) in
                    acc = acc + current
                }
            case .product:
                var copy = lhsValue
                for (index, element) in copy.enumerated() {
                    let test = element + rhs
                    if case product = test {
                        copy[index] = test
                        return sum(copy)
                    }
                }
                return sum(lhsValue + [rhs])
            case .costant(let value):
                var copy = lhsValue
                for (index, addend) in copy.enumerated() {
                    if case costant(let lhsAddend) = addend {
                        let newValue = lhsAddend + value
                        guard newValue != 0 else {
                            copy.remove(at: index)
                            return .sum(copy)
                        }
                        copy[index] = .costant(newValue)
                        return .sum(copy)
                    }
                }
                return sum(copy + [rhs])
            default:
                return rhs + lhs
            }
        case .product:
            switch rhs {
            case .product:
                if let lhsMonomial = lhs.separateCoefficent() {
                    if let rhsMonomial = rhs.separateCoefficent() {
                        if Set(lhsMonomial.1) == Set(rhsMonomial.1) {
                            let newCoefficent = lhsMonomial.0 + rhsMonomial.0
                            return coefficentTest(newCoefficent, otherResult: rhsMonomial.1)
                        } else {
                            return .sum([lhs, rhs])
                        }
                    }
                }
                assertionFailure("Error in multplication between two products")
                return 0
            default:
                return rhs + lhs
            }
        default:
            switch rhs {
            case .costant:
                return rhs + lhs
            case .sum(let rhsValues):
                var copy = rhsValues
                for (index, element) in copy.enumerated() {
                    let test = lhs + element
                    guard case sum = test else {
                        if test == 0 {
                            copy.remove(at: index)
                        } else {
                            copy[index] = test
                        }
                        return sum(copy)
                    }
                }
                if case costant = rhsValues.last! {
                    copy.insert(lhs, at: rhsValues.count)
                } else {
                    copy.append(lhs)
                }
                return sum(copy)
            case .product:
                if let monomial = rhs.separateCoefficent() {
                    if monomial.1 == [lhs] {
                        let newCoefficent = monomial.0 + 1
                        return coefficentTest(newCoefficent, otherResult: [lhs])
                    }
                }
                return .sum([rhs, lhs])
            case .fraction:
                return rhs + lhs
            default:
                if rhs == lhs {
                    return .product([.costant(2), lhs])
                } else {
                    return .sum([lhs, rhs])
                }
            }
        }
    }
}
