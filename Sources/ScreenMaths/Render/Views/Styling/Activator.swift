//
//  Activator.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 27/07/20.
//

import Foundation
import SwiftUI

public protocol Activator: ViewModifier {
    
    var activated: Bool { get set }
    
    init(activated: Bool)
    
}

public struct DefaultActivator: Activator {
    
    @Environment(\.mathScale) var scale: CGFloat
    
    public var activated: Bool
    
    public init(activated: Bool) {
        self.activated = activated
    }
    
    public func body(content: Content) -> some View {
        Group {
            if activated {
                HStack {
                    content
                    Rectangle()
                        .frame(width: 2)
                        .foregroundColor(.blue)
                }
            } else {
                content
            }
        }
    }
    
}
