//
//  SwiftUIView.swift
//  
//
//  Created by Giulio Ferraro on 27/12/20.
//

import SwiftUI

struct RootMainShape: Shape {
    
    @Environment(\.mathStyle) var style: Style
    
    @Environment(\.mathScale) var scale: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: 0, y: rect.height - scale * style.armRelativeHeight))
            p.addLine(to: CGPoint(x: scale * style.rootSignWidth1, y: rect.height))
            p.addLine(to: CGPoint(x: scale * style.rootSignWidth2, y: 0))
            p.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
}

struct RootMainShape_Previews: PreviewProvider {
    static var previews: some View {
        RootMainShape().stroke(lineWidth: 3.0)
            .frame(width: 300, height: 100, alignment: .center)
    }
}
