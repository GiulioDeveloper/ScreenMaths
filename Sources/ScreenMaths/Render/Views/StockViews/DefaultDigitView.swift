//
//  DigitView.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 20/07/2020.
//

import SwiftUI

struct DefaultDigitView: View {
    
    var number: UInt8
    
    @Environment(\.mathScale) var scale: CGFloat
    
    var body: some View {
        Text("\(Int(number))")
            .font(.system(size: scale))
    }
}

struct DigitView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultDigitView(number: 8)
    }
}
