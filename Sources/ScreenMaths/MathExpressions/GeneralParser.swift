//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 12/11/20.
//

import Foundation

public class GeneralParser {
    
    public init(input: String) {
        self.input = input
    }
    
    var input: String
    
    public func parse() -> Result<Container, ParsingError> {
        
        if let index = input.firstIndex(of: "=") {
            let leftTextParser = TextParser(input: String(input[input.startIndex ..< index]))
            let leftParsed = leftTextParser.parse()
            let rightTextParser = TextParser(input: String(input[input.index(after: index) ..< input.endIndex]))
            let rightParsed = rightTextParser.parse()
            return leftParsed.flatMap { left in
                rightParsed.map { right in
                    Container.equation(left: left, right: right)
                }
            }
        } else {
            let textParser = TextParser(input: self.input)
            return textParser.parse().map {
                Container.expression($0)
            }
        }
    }
    
}
