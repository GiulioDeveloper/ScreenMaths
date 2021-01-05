//
//  PlusView.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 20/07/2020.
//

import SwiftUI

struct DefaultPlusView: View {
    
    @Environment(\.mathStyle) var style: Style
    
    @Environment(\.mathScale) var scale: CGFloat
    
    var body: some View {
        PlusShape()
            .stroke(lineWidth: style.size(scale, for: \.relativeLineWidth))
            .frame(width: scale, height: scale)
            .foregroundColor(style.operatorsColor)
    }
}

struct PlusView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultPlusView()
    }
}
