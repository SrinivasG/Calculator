//
//  CalcViewModel.swift
//  Calculator
//
//  Created by Gadda Srinivas on 08/10/19.
//  Copyright © 2019 Srinivas G. All rights reserved.
//

import UIKit

enum Tag: Int {
    case zero = 1, one, two, three, four, five, six, seven, eight, nine, plus, minus, mul, div, equal, dot, inverse, percent
}

protocol CalcDelegate: class {
    func updateValueToDisplay(value: String)
    func showInfo(msg: String)
    func enableClearButton(enable: Bool)
}

class CalcViewModel: NSObject {
    
    fileprivate var calcModel: CalcModel = CalcModel()
    
    fileprivate var isPerformingOperation: Bool = false
    
    weak var calculationDelegate: CalcDelegate?
    
    override init() {
        super.init()
    }
    
    func numberTapped (existingNum: String, tagValue: Tag) {
        calculationDelegate?.enableClearButton(enable: true)
        
        var numberToDisplay = "0"
        
        if isPerformingOperation == true {
            isPerformingOperation = false
            numberToDisplay = String(tagValue.rawValue-1)
            
        } else {
            numberToDisplay = existingNum + String(tagValue.rawValue-1)
        }
        
        let updatedVal = numberToDisplay.formatPreZeroIfExists
        calculationDelegate?.updateValueToDisplay(value: updatedVal)
        calcModel.secondaryVal =  Double(updatedVal)!
    }
    
    func operatorPerformed(with number: Double, tagVal: Tag) {
        
        switch tagVal {
        case .plus, .minus, .mul, .div:
            
            isPerformingOperation = true
            calcModel.primaryVal = number
            calcModel.secondaryVal = 0
        
        case .inverse, .percent :
            calculationDelegate?.showInfo(msg: "Thanks for using our application! We will be working to get you this operation very soon..")
            return
            
        default:
            print("")
        }
        switch tagVal {
        case .plus:
            calcModel.operation = .add
            
        case .minus:
            calcModel.operation = .sub
            
        case .mul:
            calcModel.operation = .mul
            
        case .div:
            calcModel.operation = .div
            
        case .equal:
            performCalculation()
            resetModel()
            
        default:
            print("")
        }
        
    }
    
    func performCalculation() {
        switch calcModel.operation {
        case .add:
            calcModel.result = (calcModel.primaryVal+calcModel.secondaryVal)
        case .sub:
            calcModel.result = (calcModel.primaryVal-calcModel.secondaryVal)
        case .mul:
            calcModel.result = (calcModel.primaryVal*calcModel.secondaryVal)
        case .div:
            calcModel.result = (calcModel.primaryVal/calcModel.secondaryVal)
        default:
            print("")
        }
        
        calculationDelegate?.updateValueToDisplay(value: calcModel.result.cleanPrecision)
    }
    func resetModel () {
        calcModel.operation = .none
        calcModel.primaryVal = 0
        calcModel.secondaryVal = 0
        calcModel = CalcModel()
    }
    func clearResult() {
        resetModel()
        calculationDelegate?.enableClearButton(enable: false)
        calculationDelegate?.updateValueToDisplay(value: calcModel.result.cleanPrecision)
    }
    
}
extension Double {
    var cleanPrecision: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%f", self)
    }
}
extension String {
    var formatPreZeroIfExists: String {
        var existingStr = self
        if !existingStr.isEmpty && existingStr.count>1 && existingStr.first == "0" {
            existingStr.remove(at: existingStr.startIndex)
            return existingStr
        } else {
            return existingStr
        }
    }
}
