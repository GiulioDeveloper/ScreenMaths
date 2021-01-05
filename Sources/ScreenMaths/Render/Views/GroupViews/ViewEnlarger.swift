//
//  ViewEnlarger.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 29/07/20.
//

import Foundation
import SwiftUI

struct ViewEnlargerModifier: ViewModifier {
    
    var left: CGFloat? = nil
    
    var right: CGFloat? = nil
    
    var top: CGFloat? = nil
    
    var bottom: CGFloat? = nil

    
    func body(content: Content) -> some View {
        
        HStack {
            
            Spacer()
                .frame(width: left ?? 0)
            
            VStack {
                
                Spacer()
                    .frame(height: top ?? 0)
                
                content
                
                Spacer()
                    .frame(height: bottom ?? 0)
                
            }
            
            Spacer()
                .frame(width: right ?? 0)
            
        }
        
    }
    
}

extension View {
    
    func enlarge(left: CGFloat? = nil, right: CGFloat? = nil, top: CGFloat? = nil, bottom: CGFloat? = nil) -> some View {
        self.modifier(ViewEnlargerModifier(left: left, right: right, top: top, bottom: bottom))
    }
    
    func enlarge(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        self.modifier(ViewEnlargerModifier(left: width, right: width, top: height, bottom: height))
    }
    
}
