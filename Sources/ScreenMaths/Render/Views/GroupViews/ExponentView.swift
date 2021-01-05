//
//  ExponentView.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 23/07/2020.
//

import SwiftUI

struct ExponentView<ActivatorType: Activator> : View {
    
    var group: RGroup
    
    @Environment(\.mathStyle) var style: Style
    
    @Environment(\.mathScale) var scale: CGFloat
    
    @Environment(\.mathDepth) var depth: Int
    
    var baseSet: RSet {
        group[0]
    }
    
    var exponentSet: RSet {
        group[1]
    }
    
    var alignment: VerticalAlignment {
        VerticalAlignment(MathAlignments.maths[depth])
    }
    
    var body: some View {
        
        HStack(spacing: style.size(scale, for: \.exponentSpace)) {
            
            MathView(set: baseSet)
                .equatable()
                .alignmentGuide(VerticalAlignment.center, computeValue: { $0[VerticalAlignment.top] })
            
            MathView(set: exponentSet)
                .equatable()
                .alignmentGuide(VerticalAlignment.center) { $0[.bottom] - style.size(scale, for: \.exponentOffset) }
                .environment(\.mathScale, style.size(scale, for: \.exponentSize))
                .environment(\.mathDepth, depth + 1)
            
        }
        
    }
}


//struct ExponentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExponentView()
//    }
//}
