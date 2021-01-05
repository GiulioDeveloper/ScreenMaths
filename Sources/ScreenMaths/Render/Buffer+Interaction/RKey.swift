//
//  RKey.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 19/07/2020.
//

import Foundation
import SwiftUI

public class RKey: Identifiable, Hashable {

    public var id = UUID()
    
    var key: MathKey
    
    weak var set: RSet!
    
    var activated: Bool = false
    
    lazy var isAlone = true
    
    var copy: RKey {
        return RKey(id: self.id, key: self.key, set: self.set, activated: self.activated)
    }
    
    func changeSet(to set: RSet) -> RKey {
        self.set = set
        return self
    }
    
    public init(id: UUID = UUID(), key: MathKey, set: RSet? = nil,  activated: Bool = false) {
        self.id = id
        self.key = key
        self.set = set
        self.activated = activated
    }
    
    
    public static func == (lhs: RKey, rhs: RKey) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(key)
    }
    
}


