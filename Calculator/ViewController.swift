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
    @IBOutlet weak var buttonAC: UIButton!
    
    private var isDecimalUsed: Bool = false
    private var isFinishedTypingNumber: Bool = true

    @IBAction func calcButtonPressed(_ sender: UIButton) {

        isFinishedTypingNumber = true
        
        if displayLabel.text == "." {
            displayLabel.text = "0."
        }
        
        guard let number = Double(displayLabel.text!) else {
            fatalError("Can not convert display label text to Double")
        }
        
        if let calcMethod = sender.currentTitle {
    
            if calcMethod == "AC" {
                isDecimalUsed = false
                displayLabel.text = "0"
                resultLabel.text = "Result"
            } else if calcMethod == "+/-" {
                resultLabel.text = String(number * -1)
            } else if calcMethod == "%"{
                resultLabel.text = String(number / 100)
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

