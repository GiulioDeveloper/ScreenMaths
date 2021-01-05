//
//  SwiftUIView.swift
//  
//
//  Created by Giulio Ferraro on 25/11/20.
//

import SwiftUI

struct QuickMathView<ActivatorType: Activator>: View {
    
    var set: RSet

    public init(text: String, _ activator: ActivatorType.Type) {
        let parsedExpression = GeneralParser(input: text).parse()
        let set = RSet()
        if case .success(let value) = parsedExpression {
            value.generateBuffer(in: set)
        }
        self.set = set
    }
    
    var body: some View {
        MathView(set: set)
            .environmentObject(InteractionManager(set: set))
    }
}

extension QuickMathView {
    /// Create a MathView from a text that formats an equation. This type of MathView is not editable. To make it editable you must create a RSet and use the other initializer.
    /// - Parameter text: An equation written in conventional text.
    public init(text: String) where ActivatorType == DefaultActivator {
        let parsedExpression = GeneralParser(input: text).parse()
        let set = RSet()
        if case .success(let value) = parsedExpression {
            value.generateBuffer(in: set)
        }
        self.set = set
    }
}

struct QuickMathView_Previews: PreviewProvider {
    static var previews: some View {
        QuickMathView(text: "x + 2 ^ (x+2)")
    }
}
