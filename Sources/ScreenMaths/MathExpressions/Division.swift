//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 08/10/20.
//

import Foundation

extension Expression {
    
    public static func / (_ lhs: Expression, _ rhs: Expression) -> Expression  {
        return fraction(num: lhs, den: rhs)
    }
    
}
