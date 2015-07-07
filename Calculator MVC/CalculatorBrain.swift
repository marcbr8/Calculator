//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Marc Balaguer on 06/07/15.
//  Copyright (c) 2015 Marc Balaguer. All rights reserved.
//

import Foundation


class CalculatorBrain{
    
    private enum Op: Printable{
        case BinaryOperation(String, (Double,Double) -> Double)
        case UnaryOperation(String, Double->Double)
        var description:String{
            get{
                switch self{
                case .BinaryOperation(let symbol, _):
                    return symbol
                case .UnaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    
    private var operandStack = [Double]()
    private var knownOperators = [String:Op]()
    private var currentOperator: Op?
    
    init(){
        
        func learnOperation(op: Op){
            knownOperators[op.description] = op
        }
        
        learnOperation(Op.BinaryOperation("+"){$0 + $1})
        learnOperation(Op.BinaryOperation("−"){$0 - $1})
        learnOperation(Op.BinaryOperation("×"){$0 * $1})
        learnOperation(Op.BinaryOperation("÷"){$0 / $1})
        learnOperation(Op.UnaryOperation("="){$0})
        
        
    }
    
    func evaluate() -> Double{
        if(currentOperator != nil){
            let op = knownOperators[currentOperator!.description]!
            switch op{
            case .BinaryOperation(_, let operation):
                let result = operation(operandStack.removeAtIndex(0), operandStack.removeLast())
                operandStack.append(result)
                return result
            case .UnaryOperation(_, _):
                return operandStack.removeLast()
            }
        } else {
            return operandStack.last!
        }
        
    }
    
    func pushOperand(newOperand:Double){
        operandStack.append(newOperand)
    }
    
    func setCurrentOperator(newCurrentOperator:String?){
        if newCurrentOperator == nil{
            currentOperator = nil
            return
        }
        if let op = knownOperators[newCurrentOperator!]{
            currentOperator = op
        }
    }
    
    func hasAPendingOperation() ->Bool{
        let hasOperator = (currentOperator != nil)
        return hasOperator
    }
    
    func resetCalculator(){
        currentOperator = nil
        operandStack.removeAll(keepCapacity: false)
        
    }
    
}