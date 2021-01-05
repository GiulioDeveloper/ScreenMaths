//
//  SwiftUIView.swift
//  
//
//  Created by Giulio Ferraro on 27/12/20.
//

import SwiftUI

struct DefaultArmView: View {
    
    @Environment(\.mathStyle) var style: Style
    
    @Environment(\.mathScale) var scale: CGFloat
    
    var body: some View {
        Rectangle()
            .foregroundColor(.gray)
            .frame(height: style.size(scale, for: \.relativeLineWidth), alignment: .center)
    }
}

struct DefaultArmView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultArmView()
    }
}
