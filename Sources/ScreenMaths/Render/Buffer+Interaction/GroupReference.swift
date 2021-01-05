//
//  GroupReference.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 15/08/20.
//

import Foundation

class GroupReference {
    
    var group: RGroup
    
    var position: Int
    
    internal init(group: RGroup, position: Int) {
        self.group = group
        self.position = position
    }
}
