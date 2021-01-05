//
//  MathViewStyle.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 19/07/2020.
//

import Foundation
import SwiftUI


public class ElementsAspect {

    public var digitsAspect = AnyDigitStyle(DefaultDigitStyle())
    
    public var placeholdersAspect = AnyPlaceholderStyle(DefaultPlaceholderStyle())
    
    public var operatorTextsAspect = AnyOperatorTextStyle(DefaultOperatorTextStyle())
    
    public var variablesAspect = AnyVariableStyle(DefaultVariableStyle())
    
    public init() {}
    
}



public struct ElementsAspectKey: EnvironmentKey {
    public static let defaultValue: ElementsAspect = ElementsAspect()
}


extension EnvironmentValues {
    public var mathElementsAspect: ElementsAspect {
        get {
            return self[ElementsAspectKey.self]
        }
        set {
            self[ElementsAspectKey.self] = newValue
        }
    }
}

