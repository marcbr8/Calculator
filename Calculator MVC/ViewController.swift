//
//  ViewController.swift
//  Calculator
//
//  Created by Marc Balaguer on 05/07/15.
//  Copyright (c) 2015 Marc Balaguer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var brain = CalculatorBrain()
    
    var userIsCurrentlyTyppingNumber: Bool = false
    var operationNumbers = Array<Double>()
    var currentOperator: String?
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if(userIsCurrentlyTyppingNumber){
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsCurrentlyTyppingNumber = true
        }
        
    }
    
    @IBAction func resetCalculator() {
        userIsCurrentlyTyppingNumber = false
        brain.resetCalculator()
        displayValue = 0
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let action = sender.currentTitle!
        
        brain.pushOperand(displayValue)
        
        userIsCurrentlyTyppingNumber = false
        let result = brain.evaluate()
        displayValue = result
        brain.setCurrentOperator(action)
    }
    
    var displayValue: Double{
        
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text! = "\(newValue)"
            userIsCurrentlyTyppingNumber = false
        }
    }
    
}

