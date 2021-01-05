//
//  LogView.swift
//  Rendering
//
//  Created by Giulio Ferraro on 30/10/20.
//

import SwiftUI

enum Log: MyAlignment {}


struct LogView<ActivatorType: Activator> : View {
    
    var group: RGroup
    
    @Environment(\.mathStyle) var style: Style
    
    @Environment(\.mathScale) var scale: CGFloat
    
    @Environment(\.mathDepth) var depth: Int
    
    @Environment(\.mathElementsAspect) var aspects: ElementsAspect
    
    var basetSet: RSet {
        group[0]
    }
    
    var argumentSet: RSet {
        group[1]
    }
    
    var alignment: VerticalAlignment {
        VerticalAlignment(MathAlignments.maths[depth])
    }
    
    var LogAlignment: VerticalAlignment {
        VerticalAlignment(Log.self)
    }
    
    var body: some View {
        
        Group{
            HStack {
            aspects.operatorTextsAspect.makeBody(text: "log")
                .alignmentGuide(alignment, computeValue: { $0[VerticalAlignment.center] })
                .alignmentGuide(VerticalAlignment.center, computeValue: { $0[VerticalAlignment.bottom] })
            
            
            MathView(set: basetSet)
                .equatable()
                .alignmentGuide(VerticalAlignment.center) { $0[.top] + style.size(scale, for: \.logOffset) }
                .environment(\.mathScale, style.size(scale, for: \.logSize))
                .environment(\.mathDepth, depth + 1)
            }
            
            BracketsView<ActivatorType>(group: nil, directSet: argumentSet)
        }
        
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView<DefaultActivator>(group: RGroup())
    }
}
