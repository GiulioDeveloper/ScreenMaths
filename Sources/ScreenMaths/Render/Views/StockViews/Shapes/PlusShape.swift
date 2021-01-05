//
//  PlusShap.swift
//  Physics Genius
//
//  Created by Giulio Ferraro on 29/04/2020.
//  Copyright © 2020 Giulio Ferraro. All rights reserved.
//

import SwiftUI

struct PlusShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path { p in
            p.move(to: CGPoint(x: rect.width / 5, y: rect.height / 2))
            p.addLine(to: CGPoint(x: rect.width * 4 / 5, y: rect.height / 2))
            p.move(to: CGPoint(x: rect.width / 2, y: rect.height / 5))
            p.addLine(to: CGPoint(x: rect.width / 2, y: rect.height * 4 / 5))
        }
    }
}

struct PlusShap_Previews: PreviewProvider {
    static var previews: some View {
        PlusShape().stroke(lineWidth: 2.0)
    }
}
