//
//  LogStyle.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 10/08/20.
//

import SwiftUI

public protocol OperatorTextStyle {

    associatedtype Body: View
    
    func makeBody(text: String) -> Body
    
}

extension OperatorTextStyle {
    
    var typeErased: AnyOperatorTextStyle {
        AnyOperatorTextStyle(self)
    }
    
}

public class AnyOperatorTextStyle: OperatorTextStyle {
    
    private let typeErasedBody: (String) -> AnyView
        
    public init<T: OperatorTextStyle>(_ style: T) {
        typeErasedBody = { text in AnyView(style.makeBody(text: text)) }
    }
    
    public func makeBody(text: String) -> AnyView {
        typeErasedBody(text)
    }
    
}

public class DefaultOperatorTextStyle: OperatorTextStyle {
    
    public func makeBody(text: String) -> some View {
        DefaultOperatorTextView(text: text)
    }
    
    public init() {}
}
