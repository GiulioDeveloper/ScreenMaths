//
//  ImportantViews.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 19/07/2020.
//

import SwiftUI

protocol MyAlignment: AlignmentID {
    
}

extension MyAlignment {
    static func defaultValue(in d: ViewDimensions) -> CGFloat {
        return d[VerticalAlignment.center]
    }
}

class MathAlignments {
    
    enum math0: MyAlignment {}
    enum math1: MyAlignment {}
    enum math2: MyAlignment {}
    enum math3: MyAlignment {}
    enum math4: MyAlignment {}
    enum math5: MyAlignment {}
    enum math6: MyAlignment {}
    enum math7: MyAlignment {}
    
    static let maths: [AlignmentID.Type] = [math0.self, math1.self, math2.self, math3.self, math4.self, math5.self, math6.self, math7.self]
}

