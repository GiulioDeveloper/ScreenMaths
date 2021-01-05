//
//  DefaultBracketsView.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 29/07/20.
//

import SwiftUI

struct DefaultBracketView: View {
    
    @Environment(\.mathStyle) var style: Style
    
    @Environment(\.mathScale) var scale: CGFloat
    
    var body: some View {
        BracketShape()
            .stroke(style: StrokeStyle(lineWidth: style.size(scale, for: \.relativeLineWidth), lineCap: .round))
            .foregroundColor(style.operatorsColor)
        
    }
}

struct DefaultBracketView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultBracketView()
    }
}
