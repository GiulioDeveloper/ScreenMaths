//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 01/12/20.
//

import Foundation

struct ParserKeyword {
    
    var key: String
    
    var trasform: (Expression) -> Expression
    
}

struct CompoundKeyword {
    
    var key: String
    
    var normalTrasform: (Expression, Expression) -> Expression
    
    var particularTrasform: (Expression) -> Expression
    
}
