//
//  VariableStyle.swift
//  Rendering
//
//  Created by Giulio Ferraro on 17/09/20.
//

import Foundation
import SwiftUI

public protocol VariableStyle {

    associatedtype Body: View
    
    func makeBody(symbol: Symbol) -> Body
    
}

extension VariableStyle {
    
    var typeErased: AnyVariableStyle {
        AnyVariableStyle(self)
    }
    
}

public class AnyVariableStyle: VariableStyle {
    
    private let typeErasedBody: (Symbol) -> AnyView
        
    public init<T: VariableStyle>(_ style: T) {
        typeErasedBody = { (symbol) in AnyView(style.makeBody(symbol: symbol)) }
    }
    
    public func makeBody(symbol: Symbol) -> AnyView {
        typeErasedBody(symbol)
    }
    
}

public class DefaultVariableStyle: VariableStyle {
    
    public func makeBody(symbol: Symbol) -> some View {
        DefaultVariableView(symbol: symbol)
    }
    
    public init() {}
    
}
