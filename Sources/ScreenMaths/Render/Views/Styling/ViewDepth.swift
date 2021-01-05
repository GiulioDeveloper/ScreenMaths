//
//  ViewDepth.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 27/07/20.
//

import Foundation
import SwiftUI

public struct DepthKey: EnvironmentKey {
    public static let defaultValue: Int = 0
}


extension EnvironmentValues {
    public var mathDepth: Int {
        get {
            return self[DepthKey.self]
        }
        set {
            self[DepthKey.self] = newValue
        }
    }
}
