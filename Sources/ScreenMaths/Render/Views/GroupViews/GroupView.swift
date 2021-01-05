//
//  GroupView.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 20/07/2020.
//

import SwiftUI

struct GroupView<ActivatorType: Activator> : View {
    
    var groupType: GroupKey
    
    var body: some View {
        Group {
            switch groupType.mode {
            case .fraction:
                FractionView< ActivatorType>(group: groupType.group)
            case .exponent:
                ExponentView< ActivatorType>(group: groupType.group)
            case .brackets:
                BracketsView< ActivatorType>(group: groupType.group)
            case .logarithm:
                LogView<ActivatorType>(group: groupType.group)
            case .root:
                RootView<ActivatorType>(group: groupType.group)
            case .modulus:
                AbsView<ActivatorType>(group: groupType.group)
            case .unOperation(let text):
                UnaryOperationView<ActivatorType>(group: groupType.group, text: text)
            }
        }
        
    }
    
}

//struct GroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupView()
//    }
//}
