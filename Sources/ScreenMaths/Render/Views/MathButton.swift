//
//  MathButton.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 20/07/2020.
//

import SwiftUI

struct MathButton<ActionView: View>: View {
    
    @EnvironmentObject var interactionManager: InteractionManager
    
    let containedView: () -> ActionView
    
    let interaction: (InteractionManager) -> Void
    
    init(@ViewBuilder containedView: @escaping () -> ActionView, interaction: @escaping (InteractionManager) -> Void) {
        self.containedView = containedView
        self.interaction = interaction
    }
    
    var body: some View {
        Button(action: {
            interaction(interactionManager)
        }) {
            containedView()
        }
    }
}
//
//struct MathButton_Previews: PreviewProvider {
//    static var previews: some View {
//        MathButton()
//    }
//}
