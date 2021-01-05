//
//  ViewScale.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 27/07/20.
//

import Foundation
import SwiftUI

public struct ScaleKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 50
}


extension EnvironmentValues {
    public var mathScale: CGFloat {
        get {
            return self[ScaleKey.self]
        }
        set {
            self[ScaleKey.self] = newValue
        }
    }
}
