//
//  BracketShape.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 29/07/20.
//

import Foundation
import SwiftUI

struct BracketShape: Shape {
    
    let control: CGFloat = 0.25

    func path(in rect: CGRect) -> Path {
        return Path { p in
            p.move(to: CGPoint(x: rect.width, y: 0))
            p.addQuadCurve(to: CGPoint(x: 0, y: rect.height * control),
                           control: CGPoint(x: 0, y: 0))
            p.addLine(to: CGPoint(x: 0, y: rect.height * (1 - control) ))
            p.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height),
                           control: CGPoint(x: 0, y: rect.height))
        }
    }
    

}

struct BracketShape_Previews: PreviewProvider {
    static var previews: some View {
        BracketShape()
            .frame(width: 10, height: 50)
    }
}
