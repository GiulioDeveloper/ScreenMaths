//
//  InteractionManager.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 19/07/2020.
//

import Foundation
import SwiftUI

/// A class that manages interaction and editing of a MathView through RSets
public class InteractionManager: ObservableObject {
    
    var previousKey: RKey?
    
    var currentSet: RSet
    
    let startSet: RSet
    
    var isEditing: Bool = true
    
    @Published var currentMomentHolder: Int = 0
    
    var currentMoment: Int {
        set(value) {
            if let key = previousKey {
                key.activated = false
            }
            currentSet[value].activated = true
            previousKey = currentSet[value]
            currentMomentHolder = value
        }
        get {
            currentMomentHolder
        }
    }
    
    @Published var update = false
    
    var currentKey: RKey {
        return currentSet[currentMoment]
    }
    
    public init(set: RSet) {
        self.currentSet = set
        self.startSet = set
    }
    
}
