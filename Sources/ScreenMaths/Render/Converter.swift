//
//  Converter.swift
//  Rendering
//
//  Created by Giulio Ferraro on 05/11/20.
//

import Foundation

public class Converter {
    
    public init(input: RSet) {
        self.input = input
    }
    
    var input: RSet
    
    public func getText() -> String {
        var result = ""
        for element in input.keys {
            switch element.key {
            case .digit(let value):
                result = result + String(value)
            case .variable(let symbol):
                result = result + symbol.description
            case .plus:
                result = result + " + "
            case .minus:
                result = result + " - "
            case .equalSign:
                result = result + " = "
            case .placeHolder:
                continue
            case .group(let groupType):
                switch groupType.mode {
                case .root:
                    let converterBase = Converter(input: groupType.group.members[0])
                    let converterExp = Converter(input: groupType.group.members[1])
                    result = result + "root(\(converterBase.getText()), \(converterExp.getText()))"
                case .fraction:
                    let converterNum = Converter(input: groupType.group.members[0])
                    let converterDen = Converter(input: groupType.group.members[1])
                    result = result + "(\(converterNum.getText())) / (\(converterDen.getText()))"
                case .exponent:
                    let converterBase = Converter(input: groupType.group.members[0])
                    let converterExp = Converter(input: groupType.group.members[1])
                    result = result + "(\(converterBase.getText())) ^ (\(converterExp.getText()))"
                case .brackets:
                    let converterBrackets = Converter(input: groupType.group.members[0])
                    result = result + "(\(converterBrackets.getText()))"
                case .logarithm:
                    let converterBase = Converter(input: groupType.group.members[0])
                    let converterArg = Converter(input: groupType.group.members[1])
                    result = result + "log(\(converterBase.getText()), \(converterArg.getText()))"
                case .modulus:
                    let converterContent = Converter(input: groupType.group.members[0])
                    result = result + "abs(\(converterContent.getText()))"
                case .unOperation(let text):
                    let converterContent = Converter(input: groupType.group.members[0])
                    result = result + "\(text)(\(converterContent.getText()))"
                }
            }
        }
        return result
    }
    
}
