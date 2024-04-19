//
//  CalcModel.swift
//  Calculator
//
//  Created by Gadda Srinivas on 08/10/19.
//  Copyright © 2019 Srinivas G. All rights reserved.
//

import Foundation

enum Operator {
    case add
    case sub
    case mul
    case div
    case equal
    case none
}

class CalcModel {
    var primaryVal: Double = 0
    var secondaryVal: Double = 0
    var operation: Operator = .none
    var result: Double = 0
}

