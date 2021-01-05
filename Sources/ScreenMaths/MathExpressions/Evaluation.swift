//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 08/09/20.
//

import Foundation

extension Expression {
    
    public func evaluate(using substitutions: [Symbol : Double]) -> Double? {
        switch self {
        case .costant(let value):
            return Double(value)
        case .variable(let value):
            if let correspondentValue = substitutions[value] {
                return correspondentValue
            } else {
                return nil
            }
        case .sum(let values):
            return values.map { $0.evaluate(using: substitutions) }.reduce(0, {
                myTry($0, $1, +)
            })
        case .product(let values):
            return values.map { $0.evaluate(using: substitutions) }.reduce(1, {
                myTry($0, $1, *)
            })
        case .fraction(num: let num, den: let den):
            return myTry(num.evaluate(using: substitutions), den.evaluate(using: substitutions), /)
        case .exponential(base: let base, exponent: let exponent):
            return myTry(base.evaluate(using: substitutions), exponent.evaluate(using: substitutions), pow)
        case .logarithm(base: let base, argument: let argument):
            return myTry(argument.evaluate(using: substitutions), base.evaluate(using: substitutions), {
                log($0) / log($1)
            })
        case .modulus(let argument):
            if let value = argument.evaluate(using: substitutions) {
                return abs(value)
            }
        case .cosine(let argument):
            if let value = argument.evaluate(using: substitutions) {
                return cos(value)
            }
        case .sine(let argument):
            if let value = argument.evaluate(using: substitutions) {
                return sin(value)
            }
        case .tangent(let argument):
            if let value = argument.evaluate(using: substitutions) {
                return tan(value)
            }
        case .root(base: let base, exponent: let exponent):
            return myTry(base.evaluate(using: substitutions), exponent.evaluate(using: substitutions), {
                pow($0, 1 / $1)
            })
        }
        
        return nil
    }

    public func evaluate(using number: Double) -> Double {
        switch self {
        case .costant(let value):
            return Double(value)
        case .variable:
            return number
        case .sum(let values):
            return values.map { $0.evaluate(using: number) }.reduce(0, +)
        case .product(let values):
            return values.map { $0.evaluate(using: number) }.reduce(1, *)
        case .fraction(num: let num, den: let den):
            return num.evaluate(using: number) / den.evaluate(using: number)
        case .exponential(base: let base, exponent: let exponent):
            return pow(base.evaluate(using: number), exponent.evaluate(using: number))
        case .logarithm(base: let base, argument: let argument):
            return log(argument.evaluate(using: number)) / log(base.evaluate(using: number))
        case .modulus(let argument):
            return abs(argument.evaluate(using: number))
        case .cosine(let argument):
            return cos(argument.evaluate(using: number))
        case .sine(let argument):
            return sin(argument.evaluate(using: number))
        case .root(base: let base, exponent: let exponent):
            return pow(base.evaluate(using: number), 1 / exponent.evaluate(using: number))
        case .tangent(let argument):
            return tan(argument.evaluate(using: number))
        }
        
    }
    
}

enum EvaluationError: Error {
    case variablesNotMatching
    case negativeLog
    case divisionByZero
}
