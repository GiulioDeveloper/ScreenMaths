//
//  DigitStyle.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 27/07/20.
//

import Foundation
import SwiftUI

public protocol DigitStyle {

    associatedtype Body: View
    
    func makeBody(digit: UInt8) -> Body
    
}

public extension DigitStyle {
    
    var typeErased: AnyDigitStyle {
        AnyDigitStyle(self)
    }
    
}

public class AnyDigitStyle: DigitStyle {
    
    private let typeErasedBody: (UInt8) -> AnyView
        
    public init<T: DigitStyle>(_ style: T) {
        typeErasedBody = { (digit) in AnyView(style.makeBody(digit: digit)) }
    }
    
    public func makeBody(digit: UInt8) -> AnyView {
        typeErasedBody(digit)
    }
    
}

public class DefaultDigitStyle: DigitStyle {
    
    public func makeBody(digit: UInt8) -> some View {
        DefaultDigitView(number: digit)
    }
    
    public init() {}
    
}
