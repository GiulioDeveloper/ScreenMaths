//
//  MathKey.swift
//  SwiftEquation
//
//  Created by Giulio Ferraro on 19/07/2020.
//

import Foundation

public enum MathKey: Hashable {
    case digit(UInt8)
    case variable(Symbol)
    case plus
    case minus
    case placeHolder
    case equalSign
    case group(GroupKey)
}


