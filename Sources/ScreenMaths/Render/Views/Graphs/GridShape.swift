//
//  SwiftUIView.swift
//  
//
//  Created by Giulio Ferraro on 24/12/20.
//

import SwiftUI

struct GridShape: Shape {
    
    var horizontalSpacing: Int = 48
    var verticalSpacing: Int = 48
    var traslation = (0, 0)
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let numberOfHorizontalGridLines = Int(rect.height / CGFloat(self.verticalSpacing))
            let numberOfVerticalGridLines = Int(rect.width / CGFloat(self.horizontalSpacing))
            let horizontalTraslation = CGFloat(traslation.0 % horizontalSpacing)
            let verticalTraslation = CGFloat(traslation.1 % verticalSpacing)
            for index in 0...numberOfVerticalGridLines / 2 {
                let vOffset: CGFloat = CGFloat(index) * CGFloat(self.horizontalSpacing)
                let wCenter = rect.width / 2
                path.move(to: CGPoint(x: wCenter + vOffset + horizontalTraslation, y: 0))
                path.addLine(to: CGPoint(x: wCenter + vOffset + horizontalTraslation, y: rect.height))
                path.move(to: CGPoint(x: wCenter - vOffset + horizontalTraslation, y: 0))
                path.addLine(to: CGPoint(x: wCenter - vOffset + horizontalTraslation, y: rect.height))
            }
            for index in 0...numberOfHorizontalGridLines / 2{
                let hOffset: CGFloat = CGFloat(index) * CGFloat(self.verticalSpacing)
                let hCenter = rect.height / 2
                path.move(to: CGPoint(x: 0, y: hCenter - hOffset - verticalTraslation))
                path.addLine(to: CGPoint(x: rect.width, y: hCenter - hOffset - verticalTraslation))
                path.move(to: CGPoint(x: 0, y: hOffset + hCenter - verticalTraslation))
                path.addLine(to: CGPoint(x: rect.width, y: hCenter + hOffset - verticalTraslation))
            }
        }
    }
    
}

struct GridShape_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GridShape(traslation: (30, 0)).stroke(lineWidth: 2.0)
        }
    }
}
