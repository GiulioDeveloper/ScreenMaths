//
//  BracketsView.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 29/07/20.
//

import SwiftUI

struct BracketsView<ActivatorType: Activator> : View {
    
    var group: RGroup?
    
    var directSet: RSet? = nil
    
    @Environment(\.mathStyle) var style: Style
    
    @Environment(\.mathScale) var scale: CGFloat
    
    @Environment(\.mathDepth) var depth: Int
    
    var set: RSet {
        group?[0] ?? directSet!
    }
    
    var alignment: VerticalAlignment {
        VerticalAlignment(MathAlignments.maths[depth])
    }
    
    var body: some View {
        
        HStack(spacing: style.size(scale, for: \.bracketsSpacing)) {
            DefaultBracketView()
                .frame(width: style.size(scale, for: \.bracketsWidth))
            
            MathView(set: set)
            
            DefaultBracketView()
                .frame(width: style.size(scale, for: \.bracketsWidth))
                .rotationEffect(Angle(degrees: 180))
        }
    }
}
