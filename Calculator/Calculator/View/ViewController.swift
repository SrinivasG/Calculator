//
//  ViewController.swift
//  Calculator
//
//  Created by Gadda Srinivas on 08/10/19.
//  Copyright © 2019 Srinivas G. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var resultLbl: UILabel!
    
    @IBOutlet weak var clearBtn: UIButton!
    
    var viewModel: CalcViewModel = CalcViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.calculationDelegate = self
    }

    @IBAction func precesionBtnTapped(_ sender: UIButton) {
        self.resultLbl.text = self.resultLbl.text! + "."
    }
    @IBAction func clearCalculation(_ sender: UIButton) {
        viewModel.clearResult()
    }
    @IBAction func numberTapped(_ sender: UIButton) {
        let tag: Tag = Tag(rawValue: sender.tag)!
        
        viewModel.numberTapped(existingNum: resultLbl.text!, tagValue: tag)
        
    }
    
    @IBAction func operatorTapped(_ sender: UIButton) {
       
        viewModel.operatorPerformed(with: Double(resultLbl.text!)!, tagVal: Tag(rawValue: sender.tag)!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension ViewController: CalcDelegate {
    
    func updateValueToDisplay(value: String) {
        resultLbl.text = value
    }
    func enableClearButton(enable: Bool) {
        if(enable) {
            clearBtn.isEnabled = true
            clearBtn.setTitle("C", for: .normal)
        } else {
            clearBtn.isEnabled = false
            clearBtn.setTitle("AC", for: .normal)
        }
    }
    func showInfo(msg: String) {
        let alert = UIAlertController(title: "Calculator", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let actionBtn = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel) { (action) in
            
        }
        alert.addAction(actionBtn)
        self.present(alert, animated: true) {
            
        }
    }
}
