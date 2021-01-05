//
//  UnaryOperationView.swift
//  Rendering
//
//  Created by Giulio Ferraro on 01/11/20.
//

import SwiftUI

import SwiftUI

struct UnaryOperationView<ActivatorType: Activator> : View {
    
    var group: RGroup
    
    var text: String
    
    @Environment(\.mathStyle) var style: Style
    
    @Environment(\.mathScale) var scale: CGFloat
    
    @Environment(\.mathDepth) var depth: Int
    
    @Environment(\.mathElementsAspect) var aspects: ElementsAspect
    
    var set: RSet {
        group[0]
    }
    
    var alignment: VerticalAlignment {
        VerticalAlignment(MathAlignments.maths[depth])
    }
    
    var body: some View {
        
        Group {
            aspects.operatorTextsAspect.makeBody(text: text)
                .alignmentGuide(alignment, computeValue: { $0[VerticalAlignment.center] })
            
            BracketsView<ActivatorType>(group: nil, directSet: set)
        }
        
    }
}
