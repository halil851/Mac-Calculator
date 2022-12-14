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
    
    private var isFinishedTypingNumber: Bool = true
    private var isDecimalUsed: Bool = false
    
    private var displayValue: Double {
        get {
            if displayLabel.text == "." {
                displayLabel.text = "0."
            }
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a Double.")
            }
            return number
        }
        set {
            resultLabel.text = String(newValue)
        }
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        
        
        isDecimalUsed = false
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
 
            if let result = calculator.calculate(symbol: calcMethod) {
                
                displayValue = result
            }
            
            if calcMethod == "AC" {
                isDecimalUsed = false
                displayLabel.text = "0"
                resultLabel.text = "Result"
            }
        }
    }
  

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle {
            
            if numValue == "."{
                if isDecimalUsed { return }
                isDecimalUsed = true
            }
            
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
                
            } else {
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }
}
