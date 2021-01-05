//
//  DefaultPlaceholderView.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 27/07/20.
//

import SwiftUI

struct DefaultPlaceholderView: View {
    
    @Environment(\.mathScale) var scale: CGFloat
    
    var activation: Bool
    
    var alone: Bool
    
    var body: some View {
        Rectangle()
            .frame(width: alone ? scale : 1, height: scale)
            .foregroundColor(alone ? (activation ? .blue : .gray) : .clear)
    }
    
}
