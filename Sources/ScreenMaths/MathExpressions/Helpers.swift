//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 17/08/20.
//

import Foundation

extension Dictionary {
    
    func mapKeys<T: Hashable>(_ transform: (Key) -> T, _ uniquingKeysWith: (Value, Value) -> Value) -> Dictionary<T, Value> {
        self.reduce(into: [T:Value]()) { (accumulation, pair) in
            if let existing = accumulation[transform(pair.key)] {
                accumulation[transform(pair.key)] = uniquingKeysWith(existing, pair.value)
            } else {
                accumulation[transform(pair.key)] = pair.value
            }
        }
    }
    
}

internal func resultOperation<T, E: Error>(_ lhs: Result<T, E>, _ rhs: Result<T, E>, _ operation: ((T, T) -> T)) -> Result<T, E> {
    lhs.flatMap { (lhsValue) -> Result<T, E> in
        rhs.map { (rhsValue) -> T in
            return operation(lhsValue, rhsValue)
        }
    }
}

internal func myTry<T>(_ lhs: T?, _ rhs: T?, _ operation: (T, T) -> T) -> T? {
    if let actualLhs = lhs {
        if let actualRhs = rhs {
            return operation(actualLhs, actualRhs)
        }
    }
    
    return nil
}

extension Float  {
    static func myLog(base: Float, argument: Float) -> Float {
        return log(argument) / log(base)
    }
}

extension Int {
    
    init(from digits: [UInt8]) {
        var value = 0
        for (position, digit) in digits.enumerated() {
            let esponent = digits.count - position - 1
            value += Int(digit) * (10 ^ esponent)
        }
        
        self = value
    }
    
    var digits: [UInt8] {
        var partialNumber = self
        var result = [UInt8]()
        while partialNumber > 0 {
            let digit = partialNumber % 10
            result.insert(UInt8(digit), at: 0)
            partialNumber = (partialNumber - digit) / 10
        }
        return result
    }
    
    static func ^ (_ lhs: Int, _ rhs: Int) -> Int {
        return Int(pow(Float(lhs), Float(rhs)))
    }
}


extension String {
    
    func next(after index: String.Index) -> Character {
        return self[self.index(after: index)]
    }
    
}

extension Array {
    
    static func parallelOperation<T>(_ lhs: Array<T>, _ rhs: Array<T>, _ operation: (T, T) -> T) -> Array<T> {
        var result = lhs
        for index in 0 ..< lhs.count {
            result[index] = operation(lhs[index], rhs[index])
        }
        return result
    }
}
