//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 03/01/21.
//

import SwiftUI

struct AbsView<ActivatorType: Activator> : View {
    
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
            Rectangle()
                .frame(width: style.size(scale, for: \.relativeLineWidth))
                .foregroundColor(style.operatorsColor)
            
            MathView(set: set)
            
            Rectangle()
                .frame(width: style.size(scale, for: \.relativeLineWidth))
                .foregroundColor(style.operatorsColor)
        }
    }
}
