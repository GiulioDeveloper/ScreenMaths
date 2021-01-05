//
//  FractionView.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 19/07/2020.
//

import SwiftUI

struct FractionView<ActivatorType: Activator> : View {
    
    var group: RGroup
    
    @Environment(\.mathStyle) var style: Style
    
    @Environment(\.mathScale) var scale: CGFloat
    
    @Environment(\.mathDepth) var depth: Int
    
    var numeratorSet: RSet {
        group[0]
    }
    
    var denominatorSet: RSet {
        group[1]
    }
    
    var alignment: VerticalAlignment {
        VerticalAlignment(MathAlignments.maths[depth])
    }
    
    var mySpacing: CGFloat {
        style.size(scale, for: \.fractionSpacing) + style.size(scale, for: \.fractionSeparatorSize)
    }
    
    var body: some View {
        
        VStack(spacing: mySpacing) {
            
            MathView(set: numeratorSet)
                .equatable()
                .anchorPreference(key: SizePublisherPreference.self, value: .bounds, transform: { anchor in
                    [numeratorSet.id : anchor]
                })
                .alignmentGuide(alignment) { size in
                    size[.bottom] + mySpacing / 2
                }
                            
            MathView(set: denominatorSet)
                .equatable()
                .alignmentGuide(alignment) { size in
                    size[.top] - mySpacing / 2
                }
            
        }
        .backgroundWithSize(for: numeratorSet.id) { numeratorSize in
            VStack {
                Spacer()
                    .frame(height: numeratorSize.height + (style.size(scale, for: \.fractionSpacing) / 2))
                Rectangle()
                    .foregroundColor(style.operatorsColor)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: style.size(scale, for: \.fractionSeparatorSize) ,maxHeight: style.size(scale, for: \.fractionSeparatorSize))
                    .animation(.linear(duration: 0.2))
            }
        }
        
    }
}

//struct FractionView_Previews: PreviewProvider {
//    static var previews: some View {
//        FractionView()
//    }
//}
