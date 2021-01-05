//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 06/10/20.
//

import Foundation

public class TextParser {
    
    var input: String
    
    var addingIntegerPart: Bool = true
    var currentWholeDigits = [UInt8]()
    var currentFractionaryDigits = [UInt8]()
    
    lazy var index = input.startIndex
    
    var keywords = [
        ParserKeyword(key: "cos", trasform: { Expression.cosine($0)}),
        ParserKeyword(key: "sin", trasform: { Expression.sine($0)}),
        ParserKeyword(key: "tan", trasform: { Expression.tangent($0)}),
        ParserKeyword(key: "abs", trasform: { Expression.modulus($0)}),
        ParserKeyword(key: "ln", trasform: { Expression.logarithm(base: .variable(Symbol.e), argument: $0)}),
        ParserKeyword(key: "log2", trasform: { Expression.logarithm(base: .costant(2), argument: $0)}),
        ParserKeyword(key: "sqrt", trasform: { Expression.root(base: $0, exponent: .costant(2))}),
    ]
    var compundKeywords = [CompoundKeyword(key: "log", normalTrasform: {
        Expression.logarithm(base: $0, argument: $1)
    }, particularTrasform: {
        Expression.logarithm(base: .costant(10), argument: $0)
    }),
    CompoundKeyword(key: "root", normalTrasform: {
        Expression.root(base: $0, exponent: $1)
    }, particularTrasform: {
        Expression.logarithm(base: $0, argument: .costant(2))
    })
    ]
    
    var currentProduct = [Expression]()
    var currentSum = [Expression]()
    
    public init(input: String) {
        self.input = input
    }
    
    func parse(_ breakCondition: () -> Bool) -> (Result<Expression, ParsingError>, String.Index) {
        
        input.append("+")
        
        mainLoop: while index != input.endIndex {
            
            if breakCondition() {
                return (.failure(.manuallyInterrupted), index)
            }
            
            for keyword in keywords {
                if input.distance(from: index, to: input.endIndex) > keyword.key.count - 1 { //Controlla se c'è spazio per la ricerca
                    let searchIndex = input.index(index, offsetBy: keyword.key.count - 1)
                    if input[index ... searchIndex] == keyword.key {
                        index = searchIndex
                        let operation = singleOperation(keyword.trasform)
                        if case .success(let value) = operation {
                            currentProduct.append(value)
                        } else {
                            return (operation, index)
                        }
                        continue mainLoop
                    }
                }
            }
            
            for keyword in compundKeywords {
                if input.distance(from: index, to: input.endIndex) > keyword.key.count - 1 { //Controlla se c'è spazio per la ricerca
                    let searchIndex = input.index(index, offsetBy: keyword.key.count - 1)
                    if input[index ... searchIndex] == keyword.key {
                        let newIndex = input.index(after: index)
                        if let firstIndex = input[newIndex ..< input.endIndex].firstIndex(of: "(") {
                            if let endIndex = findEndingBracket(from: firstIndex) {
                                if let commaIndex = input[firstIndex ..< endIndex].firstIndex(of: ",") {
                                    let indexAfterFirstBracket = input.index(after: firstIndex)
                                    let baseParser = TextParser(input: String(input[indexAfterFirstBracket ..< commaIndex]))
                                    let base = baseParser.parse()
                                    let indexAfterComma = input.index(after: commaIndex)
                                    let argumentParser = TextParser(input: String(input[indexAfterComma ..< endIndex]))
                                    let argument = argumentParser.parse()
                                    if case .success(let baseExpression) = base {
                                        if case .success(let argExpression) = argument {
                                            currentProduct.append(keyword.normalTrasform(baseExpression, argExpression))
                                        } else {
                                            return (argument, commaIndex)
                                        }
                                    } else {
                                        return (base, commaIndex)
                                    }
                                    index = input.index(after: endIndex)
                                    continue mainLoop
                                } else {
                                    index = searchIndex
                                    let operation = singleOperation(keyword.particularTrasform)
                                    if case .success(let value) = operation {
                                        currentProduct.append(value)
                                    } else {
                                        return (operation, index)
                                    }
                                    continue mainLoop
                                }
                            } else {
                                return (.failure(.missingParenthesis), firstIndex)
                            }
                        } else {
                            return (.failure(.missingParenthesis), newIndex)
                        }
                    }
                }
            }
            
            let character = input[index]
            
            print(character)
            
            if character.isLetter {
                if input.next(after: index) == "_" {
                    let firstBracketIndex = input.index(index, offsetBy: 2)
                    let successiveCharacter = input[firstBracketIndex]
                    if successiveCharacter == "(" {
                        if let endIndex = findEndingBracket(from: firstBracketIndex) {
                            let contentStartIndex = input.index(after: firstBracketIndex)
                            let content = input[ contentStartIndex ..< endIndex]
                            let symbol = Symbol(String(character), kind: String(content))
                            currentProduct.append(Expression.variable(symbol))
                            index = input.index(after: endIndex)
                            continue mainLoop
                        } else {
                            return (.failure(.missingParenthesis), index)
                        }
                    } else if successiveCharacter.isLetter || successiveCharacter.isNumber {
                        let symbol = Symbol(String(character), kind: String(successiveCharacter))
                        currentProduct.append(Expression.variable(symbol))
                        index = input.index(after: firstBracketIndex)
                        continue mainLoop
                    }
                } else {
                    currentProduct.append(Expression.variable(Symbol(String(character), kind: "")))
                    index = input.index(after: index)
                    continue mainLoop
                }
            }
            
            selection: switch character {
            case "0" ... "9":
                let digit = UInt8(character.wholeNumberValue!)
                if addingIntegerPart {
                    currentWholeDigits.append(digit)
                } else {
                    currentFractionaryDigits.append(digit)
                }
                let nextNumber = input.next(after: index)
                if !nextNumber.isNumber && nextNumber != "." {
                    if currentFractionaryDigits.count
                        == 0 {
                        currentProduct.append(Expression.costant(Int(from: currentWholeDigits)))
                    } else {
                        let number = Expression.costant(Int(from: currentWholeDigits + currentFractionaryDigits)) / Expression.costant(10 ^ currentFractionaryDigits.count)
                        currentProduct.append(number)
                    }
                    currentWholeDigits = []
                    currentFractionaryDigits = []
                    addingIntegerPart = true
                } else if nextNumber == "." {
                    addingIntegerPart = false
                }
            case "+":
                guard currentProduct.count != 0 else {
                    index = input.index(after: index)
                    continue mainLoop
                }
                let result = currentProduct.reduce(1, *)
                currentSum.append(result)
                currentProduct = []
            case "-":
                guard currentProduct.count != 0 else {
                    currentProduct = [.costant(-1)]
                    index = input.index(after: index)
                    continue mainLoop
                }
                let result = currentProduct.reduce(1, *)
                currentSum.append(result)
                currentProduct = [.costant(-1)]
            case "(":
                let content = parseAndMove()
                if case .success(let expression) = content {
                    currentProduct.append(expression)
                } else {
                    return (content, index)
                }
            case ")":
                return (.failure(.missingParenthesis), index)
            case "/":
                let operation = binaryOperation(/)
                if case .success(let value) = operation {
                    currentProduct.append(value)
                } else {
                    return (operation, index)
                }
                continue mainLoop
            case "^":
                let operation = binaryOperation(^)
                if case .success(let value) = operation {
                    currentProduct.append(value)
                } else {
                    return (operation, index)
                }
                continue mainLoop
            default:
                break selection
            }
            
            index = input.index(after: index)
        }
        
        return (.success(currentSum.reduce(0, +)), input.endIndex)
    }
    
    func findEndingBracket(from index: String.Index) -> String.Index? {
        let next = input.index(after: index)
        var count = 0
        for (index, character) in input[next ..< input.endIndex].enumerated() {
            if character == "(" {
                count += 1
            } else if character == ")" {
                if count == 0 {
                    return input.index(next, offsetBy: index)
                } else {
                    count -= 1
                }
            }
        }
        return nil
    }
    
    func parseAndMove() -> Result<Expression, ParsingError> {
        if let endIndex = findEndingBracket(from: index) {
            let contentStartIndex = input.index(after: index)
            let newString = String(input[contentStartIndex ..< endIndex])
            let newParsed = TextParser(input: newString).parse()
            index = endIndex
            return newParsed
        } else {
            return .failure(.missingParenthesis)
        }
    }
    
    func scanForSecondMember() -> (Expression, String.Index)? {
        let nextIndex = input.index(after: index)
        let searchedPart = String(input[nextIndex ..< input.endIndex])
        let newParser = TextParser(input: searchedPart)
        var expressionToCheck: Expression? = nil
        let parsed = newParser.parse { [unowned newParser] in
            if newParser.currentProduct.count == 1 {
                expressionToCheck = newParser.currentProduct.first!
                return true
            } else {
                return false
            }
        }
        if let expression = expressionToCheck {
            let distance = input.distance(from: input.startIndex, to: index) + searchedPart.distance(from: searchedPart.startIndex, to: parsed.1)
            let actualIndex = input.index(input.startIndex, offsetBy: distance, limitedBy: input.endIndex)!
            return (expression, actualIndex)
        }
        return nil
    }
    
    func binaryOperation(_ concatenate: (Expression, Expression) -> Expression) -> Result<Expression, ParsingError> {
        if currentProduct.count == 0 {
            return .failure(.missingFirstMember)
        } else {
            if let scanResult = scanForSecondMember() {
                index = input.index(after: scanResult.1) //Parte cambiata
                return .success(concatenate(currentProduct.removeLast(), scanResult.0))
            } else {
                return .failure(.missingSecondMember)
            }
        }
    }
    
    func singleOperation(_ trasform: (Expression) -> Expression) -> Result<Expression, ParsingError> {
        if let scanResult = scanForSecondMember() {
            index = input.index(after: scanResult.1) //Parte cambiata
            return .success(trasform(scanResult.0))
        } else {
            return .failure(.missingMember)
        }
    }
    
    public func parse() -> Result<Expression, ParsingError> {
        parse{ false }.0
    }
    
    
}


public enum ParsingError: Error {
    
    case missingMember
    case missingSecondMember
    case missingFirstMember
    case missingParenthesis
    case errorWithUnderscore
    case manuallyInterrupted
    
}
