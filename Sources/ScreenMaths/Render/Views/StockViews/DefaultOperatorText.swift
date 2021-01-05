//
//  DefaultLogView.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 10/08/20.
//

import SwiftUI

struct DefaultOperatorTextView: View {
    
    @Environment(\.mathScale) var scale: CGFloat
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: scale))
            .foregroundColor(.secondary)
    }
}

struct DefaultOperatorTextView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultOperatorTextView(text: "log")
    }
}
