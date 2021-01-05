//
//  DefaultVariableView.swift
//  Rendering
//
//  Created by Giulio Ferraro on 17/09/20.
//

import SwiftUI

struct DefaultVariableView: View {
    
    var symbol: Symbol
    
    @Environment(\.mathScale) var scale: CGFloat
    
    var body: some View {
        HStack(spacing: 0) {
            Text(symbol.name)
                .font(.system(size: scale, weight: .bold, design: .rounded))
            
            Text(symbol.kind)
                .font(.system(size: scale * 0.7, weight: .bold, design: .rounded))
                .italic()
                .alignmentGuide(VerticalAlignment.center, computeValue: { dimension in
                    return dimension[.top] / 2
                })
        }
    }
}

struct DefaultVariableView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultVariableView(symbol: Symbol("a", kind: "i"))
    }
}
