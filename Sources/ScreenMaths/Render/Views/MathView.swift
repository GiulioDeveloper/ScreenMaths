//
//  MathView.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 19/07/2020.
//

import SwiftUI


/// A view that renders a Math Equation
public struct MathView<ActivatorType: Activator> : View, Equatable {

    var set: RSet
    
    @EnvironmentObject var manager: InteractionManager
    
    @Environment(\.mathStyle) var style: Style
    
    @Environment(\.mathScale) var scale: CGFloat
    
    @Environment(\.mathDepth) var depth: Int
    
    @Environment(\.mathElementsAspect) var aspects: ElementsAspect
    
    var alignment: VerticalAlignment {
        VerticalAlignment(MathAlignments.maths[depth])
    }
    
    public var body: some View {
        
        HStack(alignment: alignment, spacing: style.size(scale, for: \.keySpacing)) {
            Group {
                ForEach(set.keys) { value in
                    switch value.key {
                    case .variable(let symbol):
                        aspects.variablesAspect.makeBody(symbol: symbol)
                            .setUp(ActivatorType.self, key: value, manager: manager, scale: scale, alignment: alignment)
                    case .digit(let digit):
                        aspects.digitsAspect.makeBody(digit: digit)
                            .setUp(ActivatorType.self, key: value, manager: manager, scale: scale, alignment: alignment)
                    case .plus:
                        DefaultPlusView()
                            .setUp(ActivatorType.self, key: value, manager: manager, scale: scale, alignment: alignment)
                    case .minus:
                        DefaultMinusView()
                            .setUp(ActivatorType.self, key: value, manager: manager, scale: scale, alignment: alignment)
                    case .equalSign:
                        DefaultEqualSignView()
                            .setUp(ActivatorType.self, key: value, manager: manager, scale: scale, alignment: alignment)
                    case .placeHolder:
                        aspects.placeholdersAspect.makeBody(activation: value.activated, alone: value.isAlone)
                            .modifier(ActivatorType(activated: value.activated && !value.isAlone && (manager.isEditing)))
                            .alignmentGuide(alignment, computeValue: { $0[VerticalAlignment.center] })
                    case .group(let groupType):
                        GroupView<ActivatorType>(groupType: groupType)
                            .modifier(ActivatorType(activated: value.activated && (manager.isEditing)))
                    }
                }
            }
            .fixedSize()
        }
        
    }
    
    public static func == (lhs: MathView<ActivatorType>, rhs: MathView<ActivatorType>) -> Bool {
        lhs.set == rhs.set
    }

    
    public init(set: RSet, activator: ActivatorType.Type) {
        self.set = set
    }
    
    
}

extension View {
    func setUp<ActivatorType: Activator>(_ activator: ActivatorType.Type, key: RKey, manager: InteractionManager?, scale: CGFloat, alignment: VerticalAlignment) -> some View {
        self
            .modifier(ActivatorType(activated: key.activated && (manager?.isEditing ?? false)))
            .alignmentGuide(alignment, computeValue: { $0[VerticalAlignment.center] })
            .onTapGesture(perform: {
                if (manager?.isEditing ?? false) {
                    manager?.currentSet = key.set
                    manager?.currentMoment = manager!.currentSet.keys.firstIndex(of: key)!
                }
            })
    }
}

extension MathView {
    /// Create a MathView starting from the set that describes its content
    /// - Parameter set: The set containing the keys of the expression
    public init(set: RSet) where ActivatorType == DefaultActivator {
        self.set = set
    }
    

}



struct MathView_Previews: PreviewProvider {
    
    static var previews: some View {
        return MathView(set: RSet())
    }
}
