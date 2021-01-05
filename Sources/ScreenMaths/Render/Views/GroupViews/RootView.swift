//
//  File.swift
//  
//
//  Created by Giulio Ferraro on 27/12/20.
//

import Foundation

import SwiftUI

enum Root: MyAlignment {}

struct RootView<ActivatorType: Activator> : View {
    
    var group: RGroup
    
    @Environment(\.mathStyle) var style: Style
    
    @Environment(\.mathScale) var scale: CGFloat
    
    @Environment(\.mathDepth) var depth: Int
    
    var baseSet: RSet {
        group[0]
    }
    
    var argumentSet: RSet {
        group[1]
    }
    
    var alignment: VerticalAlignment {
        VerticalAlignment(MathAlignments.maths[depth])
    }
    
    var RootAlignment: VerticalAlignment {
        VerticalAlignment(Root.self)
    }
    
    var body: some View {
        
        HStack(alignment: RootAlignment) {
            
            Spacer()
                .frame(width: style.size(scale, for: \.relativeLineWidth))
            
            VStack(spacing: style.size(scale, for: \.fractionSpacing)) {
                MathView(set: argumentSet)
                    .environment(\.mathScale, scale * style.exponentSize)
                    .environment(\.mathDepth, depth + 1)
                
                Rectangle()
                    .frame(height: style.size(scale, for: \.relativeLineWidth))
                    .foregroundColor(style.operatorsColor)
                
            }
            .alignmentGuide(RootAlignment, computeValue: { dimension in
                dimension[.bottom] + style.size(scale, for: \.armRelativeHeight) - style.size(scale, for: \.fractionSpacing)
        })


            MathView(set: baseSet)
                .enlarge(left: style.size(scale, for: \.rootSignWidth1) + style.size(scale, for: \.rootSignWidth2) + style.size(scale, for: \.bracketsSpacing), right: style.size(scale, for: \.bracketsSpacing), top: style.size(scale, for: \.relativeLineWidth))
                .alignmentGuide(RootAlignment, computeValue: { dimension in
                    dimension[.bottom]
                })
                .background(
                    RootMainShape()
                        .stroke(lineWidth: style.size(scale, for: \.relativeLineWidth))
                        .foregroundColor(style.operatorsColor)
                )
        }
        
    }
}
