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
    
    private var progressString = "0"
    private var isFinishedTypingNumber: Bool = true
    private var isFinishedCalculation: Bool = true
    private var isDecimalUsed: Bool = false
//    private var progress = [String]()
    
    private var displayValue: Double {
        get {
            if progressString == "." {
                progressString = "0."
            }
            guard let number = Double(progressString) else {
                fatalError("Cannot convert display label text to a Double.")
            }
            return number
        }
        set {
            decimalOrNot(newValue)
        }
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {

        isDecimalUsed = false
        isFinishedCalculation = true
    
        

        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
 
            if let result = calculator.calculate(symbol: calcMethod) {
                
                displayValue = result
            }
            
            if calcMethod == "+/-" {
                
            }
            
            if calcMethod == "=" {
                isFinishedTypingNumber = true
//                displayLabel.text = resultLabel.text
            }
            
            if calcMethod == "AC" {
                isDecimalUsed = false
                displayLabel.text = "0"
                resultLabel.text = "Result"
                isFinishedTypingNumber = true
            }
            
            if displayLabel.text != "0",
               displayLabel.text != nil,
               calcMethod != "=" {
                displayLabel.text = displayLabel.text! + calcMethod
            }
            
        }
        
    }
  

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let numValue = sender.currentTitle {
            
            if numValue == "."{
                if isDecimalUsed { return }
                isDecimalUsed = true
            }
            
            if isFinishedCalculation {
                progressString = numValue
                isFinishedCalculation = false
            } else {
                progressString = progressString + numValue
            }
            
            if isFinishedTypingNumber {
                displayLabel.text = ""
                displayLabel.text = numValue
                isFinishedTypingNumber = false
                
            } else {
                
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }
    
    func decimalOrNot(_ newValue: Double) {
        let toInt = Int(newValue)
        let toDouble = Double(toInt)
        
        if toDouble == newValue {
            resultLabel.text = String(toInt)
           
        } else {
            resultLabel.text = newValue.withCommas()
            
        }
    }
}
/// Some fractions can not be stored with exact precision in a binary file system, a universal problem with computer systems.  This side effect you describe can be fixed in Swift using NumberFormatter.
extension Double {
  func withCommas() -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = NumberFormatter.Style.decimal
    numberFormatter.maximumFractionDigits = 8  // default is 3 decimals
    return numberFormatter.string(from: NSNumber(value: self)) ?? ""
  }
}
