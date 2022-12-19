//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by halil dikişli on 13.12.2022.
//

import Foundation

struct CalculatorLogic {
    
    private var numbers = [Double]()
    private var allSymbol = [""]
    private var intermediateResult = 0.0
    
    private var number: Double?
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
   
    
    mutating func calculate(symbol: String) -> Double? {
        
        if var n = number {
            
            switch symbol {
            case "+/-":
                intermediateResult = n * -1
                print(n * -1)
                return intermediateResult
            case "AC":
                numbers.removeAll()
                allSymbol = [""]
                return 0
            case "%":
                intermediateResult = n / 100
                return intermediateResult
            case "=":
                allSymbol = [""]
                intermediateResult = performTwoNumCalculation(n2: n)!
                print("After pressing equal the Result is \(intermediateResult)")
                return intermediateResult
                
            default: // when pressed + , - , ÷ and × work below
                
                if n != 0.0 {
                    allSymbol.append(symbol)
                    let lastSymbol = allSymbol[allSymbol.count - 2]
                    
                    numbers.append(n)
                   
                    if numbers.count == 1{
                        intermediateResult = n
                    }
                    
                    switch lastSymbol {
                    case "+":
                        intermediateResult = intermediateResult + n
                    case "-":
                        intermediateResult = intermediateResult - n
                    case "×":
                        intermediateResult = intermediateResult * n
                    case "÷":
                        intermediateResult = intermediateResult / n
                    default:
                        print("")
                    }
                    
                    n = intermediateResult
                }
                intermediateCalculation = (n1: n, calcMethod: symbol) // first number
                return intermediateResult
            }
        }
        return nil
    }
    
    private mutating func performTwoNumCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1,
            let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        return nil
    }
}

