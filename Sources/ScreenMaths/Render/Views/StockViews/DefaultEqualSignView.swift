//
//  DefaultEqualSignView.swift
//  Rendering
//
//  Created by Giulio Ferraro on 12/11/20.
//

import SwiftUI

struct DefaultEqualSignView: View {

    @Environment(\.mathScale) var scale: CGFloat
    
    var body: some View {
        VStack(spacing: scale / 8) {
            Group {
                Rectangle()
                
                Rectangle()
            }
            .frame(width: scale / 1.5, height: scale / 8)
            .cornerRadius(5)
            .foregroundColor(.gray)
        }
        .frame(width: scale, height: scale)
    }
}

struct DefaultEqualSignView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultEqualSignView()
    }
}
