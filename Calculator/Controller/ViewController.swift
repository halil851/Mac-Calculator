//
//  ViewController.swift
//  Calculator
//
//  Created by halil dikişli on 13.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    private var calculationString = "0"
    private var isFinishedTypingNumber: Bool = true
    private var isFinishedCalculation: Bool = true
    private var isDecimalUsed: Bool = false
    private var isCalcButtonPressed: Bool = false
    private var isNextANumberAfterEqual : Bool = false
    
    private var displayValue: Double {
        get {
            if calculationString == "." {
                calculationString = "0."
            }
            guard let number = Double(calculationString) else {
                fatalError("Cannot convert display label text to a Double.")
            }
            return number
        }
        set {
            resultLabel.text = decimalOrNot(newValue)
        }
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isNextANumberAfterEqual = false
        isDecimalUsed = false
        isFinishedCalculation = true

        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            if let result = calculator.calculate(symbol: calcMethod) {
                
                displayValue = result
                
                if calcMethod == "%" {
                    calculationString = String(Double(calculationString)! / 100)
                    displayLabel.text = String(result)
                }
                
                if calcMethod == "+/-"{
                    calculationString = String(Double(calculationString)! * -1)
                    displayLabel.text = decimalOrNot(result)
                }
                
                if calcMethod == "=" {
                    calculationString = String(result)
                    isCalcButtonPressed = false
                    isNextANumberAfterEqual = true
                }
            }

            if calcMethod == "AC" {
                displayLabel.text = "0"
                calculationString = "0"
                resultLabel.text = "Result"
                
                isDecimalUsed = false
                isFinishedTypingNumber = true
                isCalcButtonPressed = false
            }
            
            if displayLabel.text != "0",
               displayLabel.text != nil,
               calcMethod != "=",
               calcMethod != "+/-",
               calcMethod != "%"{
                if isCalcButtonPressed {  displayLabel.text?.removeLast() }
                isCalcButtonPressed = true
                displayLabel.text = displayLabel.text! + calcMethod
            }
        }
    }
  

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if isNextANumberAfterEqual {
            displayLabel.text = ""
            isNextANumberAfterEqual = false
        }
        
        isCalcButtonPressed = false
        if let numValue = sender.currentTitle {
            
            if numValue == "."{ // avoid second "."
                if isDecimalUsed { return }
                isDecimalUsed = true
            }

            if isFinishedCalculation {
                calculationString = numValue
                isFinishedCalculation = false
            } else {
                calculationString = calculationString + numValue
            }

            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }
    
    // if result is integer, avoid to show zero after comma
    func decimalOrNot(_ newValue: Double) -> String {
        //Int.max = 9223372036854775807
        if newValue > 9223372036854775807.0 {
            print("Result can not be greater than 9223372036854775807, because of Int.max")
            return "0"
        }
        let toInt = Int(newValue)
        let toDouble = Double(toInt)
        
        if toDouble == newValue {
            return String(toInt)
           
        } else {
            return newValue.withCommas()
            
        }
    }
}

// Some fractions can not be stored with exact precision in a binary file system, a universal problem with computer systems.  This side effect can be fixed in Swift using NumberFormatter.
extension Double {
  func withCommas() -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = NumberFormatter.Style.decimal
    numberFormatter.maximumFractionDigits = 8  // default is 3 decimals
    return numberFormatter.string(from: NSNumber(value: self)) ?? ""
  }
}
