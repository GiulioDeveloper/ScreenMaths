//
//  MinusView.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 20/07/2020.
//

import SwiftUI

struct DefaultMinusView: View {
    
    @Environment(\.mathStyle) var style: Style
    
    @Environment(\.mathScale) var scale: CGFloat
    
    var body: some View {
        MinusShape()
            .stroke(lineWidth: style.size(scale, for: \.relativeLineWidth))
            .frame(width: scale, height: scale)
            .foregroundColor(style.operatorsColor)
    }
}

struct MinusView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultMinusView()
    }
}
