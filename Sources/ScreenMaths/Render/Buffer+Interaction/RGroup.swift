//
//  RGroup.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 19/07/2020.
//

import Foundation
import SwiftUI

public class RGroup: Hashable {

    weak var sender: RKey!
    
    var members:[RSet]
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(sender)
        hasher.combine(members)
    }
    
    subscript(index: Int) -> RSet {
        get {
            members[index]
        }
        set(newValue) {
            members[index] = newValue
        }
    }
    
    public static func == (lhs: RGroup, rhs: RGroup) -> Bool {
        lhs.members == rhs.members && lhs.sender == rhs.sender
    }
    
    internal init(sender: RKey? = nil, members: [RSet] = []) {
        self.sender = sender
        self.members = members
    }

}
