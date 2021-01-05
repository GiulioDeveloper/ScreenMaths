//
//  SizeInformations.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 20/07/2020.
//

import SwiftUI


struct SizePublisherPreference: PreferenceKey {
    
    typealias Value = [UUID : Anchor<CGRect>]

    static var defaultValue: Value { [UUID : Anchor<CGRect>]() }

    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value.merge(nextValue()) { a , b in
            a
        }
    }
}

extension View {
    
    func backgroundWithSize<Content: View>(for set: UUID, @ViewBuilder content: @escaping (CGRect) -> Content ) -> some View {
        self.backgroundPreferenceValue(SizePublisherPreference.self, { value in
                GeometryReader { proxy in
                    content(proxy[value[set]!])
                }
            })
    }
    
}
