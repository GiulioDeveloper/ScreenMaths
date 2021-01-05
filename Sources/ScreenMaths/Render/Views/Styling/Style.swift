//
//  AlignmentPreferences.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 19/07/2020.
//

import Foundation
import SwiftUI

public class Style {

    public var fractionSpacing: CGFloat = 0.05
    
    public var fractionSeparatorSize: CGFloat = 0.2
    
    public var keySpacing: CGFloat = 0.05
    
    public var exponentSize: CGFloat = 0.7
    
    public var exponentSpace: CGFloat = 0.1
    
    public var bracketsWidth: CGFloat = 0.5
    
    public var exponentOffset: CGFloat = 0.5
    
    public var logSize: CGFloat = 0.3
    
    public var logOffset: CGFloat = 0.4
    
    public var bracketsSpacing: CGFloat = 0.3
    
    public var rootSpaceWidth: CGFloat = 0.4
    
    public var armRelativeHeight: CGFloat = 0.3
    
    public var rootSignWidth1: CGFloat = 0.2
    
    public var rootSignWidth2: CGFloat = 0.3
    
    public var operatorsColor: Color = .gray
    
    public var relativeLineWidth: CGFloat = 0.1
    
    public init() {}
    
    public func size(_ scale: CGFloat, for property:  KeyPath<Style, CGFloat>) -> CGFloat {
        return scale * self[keyPath: property]
    }
    
}

public struct StyleKey: EnvironmentKey {
    public static let defaultValue: Style = Style()
}


extension EnvironmentValues {
    public var mathStyle: Style {
        get {
            return self[StyleKey.self]
        }
        set {
            self[StyleKey.self] = newValue
        }
    }
}
