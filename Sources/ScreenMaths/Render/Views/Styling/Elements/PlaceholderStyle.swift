//
//  PlaceholderStyle.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 27/07/20.
//

import Foundation
import SwiftUI

public protocol PlaceholderStyle {

    associatedtype Body: View
    
    func makeBody(activation: Bool, alone: Bool) -> Body
    
}

extension PlaceholderStyle {
    
    var typeErased: AnyPlaceholderStyle {
        AnyPlaceholderStyle(self)
    }
    
}

public class AnyPlaceholderStyle: PlaceholderStyle {
    
    private let typeErasedBody: (Bool, Bool) -> AnyView
        
    public init<T: PlaceholderStyle>(_ style: T) {
        typeErasedBody = { (activation, alone) in AnyView(style.makeBody(activation: activation, alone: alone)) }
    }
    
    public func makeBody(activation: Bool, alone: Bool) -> AnyView {
        typeErasedBody(activation, alone)
    }
    
}

public class DefaultPlaceholderStyle: PlaceholderStyle {
    
    public func makeBody(activation: Bool, alone: Bool) -> some View {
        DefaultPlaceholderView(activation: activation, alone: alone)
    }
    
    public init() {}
    
}
