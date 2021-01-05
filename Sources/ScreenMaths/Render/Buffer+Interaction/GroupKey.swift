//
//  GroupKey.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 23/07/2020.
//

import Foundation

public struct GroupKey: Hashable {
    
    enum Key: Hashable {
        
        case fraction
        
        case exponent
        
        case brackets
        
        case logarithm
        
        case root
        
        case modulus
        
        case unOperation(String)
        
    }
    
    var group: RGroup
    
    var mode: Key
    
    init(mode: Key) {
        self.mode = mode
        self.group = RGroup()
    }
    
}

