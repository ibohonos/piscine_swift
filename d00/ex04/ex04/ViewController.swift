//
//  ViewController.swift
//  ex02
//
//  Created by Ivan BOHONOSIUK on 10/1/18.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var operation: Int = 0
    var perfom: Bool = false
    var neg: Bool = false
    
    @IBOutlet weak var result: UILabel!
    var firstNumber: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btns(_ sender: UIButton) {
        if perfom || result.text == "0" {
            result.text = String(sender.tag - 1)
            perfom = false
        } else {
            if result.text != "0" {
                result.text = result.text! + String(sender.tag - 1)
            }
        }
        print(sender.tag - 1)
    }
    
    @IBAction func actionsBtns(_ sender: UIButton) {
        if result.text == "Division by zero!" {
            result.text = "0"
        }
        if sender.tag == 11 {
            print("AC")
            firstNumber = 0
            result.text = "0"
            operation = 0
            perfom = false
            neg = false
        } else if sender.tag == 12 {
            firstNumber = Double(result.text!)!
            if firstNumber > 0 {
                if result.text != "0" {
                    result.text = "-" + result.text!
                    neg = true
                }
            } else {
                if result.text != "0" {
                    result.text = String(-firstNumber.rounded())
                    neg = false
                }
            }
            print("NEG")
        } else if sender.tag == 13 {
            if firstNumber == 0 {
                firstNumber = Double(result.text!)!
            } else {
                firstNumber = firstNumber + Double(result.text!)!
                result.text = String(firstNumber.rounded())
            }
            operation = sender.tag
            perfom = true
            neg = false
            print("+")
        } else if sender.tag == 14 {
            if firstNumber == 0 {
                firstNumber = Double(result.text!)!
            } else {
                firstNumber = firstNumber * Double(result.text!)!
                result.text = String(firstNumber.rounded())
            }
            operation = sender.tag
            perfom = true
            neg = false
            print("*")
        } else if sender.tag == 15 {
            if firstNumber == 0 {
                firstNumber = Double(result.text!)!
            } else {
                firstNumber = firstNumber - Double(result.text!)!
                result.text = String(firstNumber.rounded())
            }
            operation = sender.tag
            perfom = true
            neg = false
            print("-")
        } else if sender.tag == 16 {
            if firstNumber == 0 {
                firstNumber = Double(result.text!)!
            } else {
                if result.text == "0" {
                    result.text = "Division by zero!"
                } else {
                    firstNumber = firstNumber / Double(result.text!)!
                    result.text = String(firstNumber.rounded())
                }
            }
            operation = sender.tag
            perfom = true
            neg = false
            print("/")
        } else if sender.tag == 17 {
            if operation == 13 {
                firstNumber += Double(result.text!)!
            } else if operation == 14 {
                firstNumber *= Double(result.text!)!
            } else if operation == 15 {
                firstNumber -= Double(result.text!)!
            } else if operation == 16 {
                if result.text != "0" {
                    firstNumber /= Double(result.text!)!
                } else {
                    result.text = "Division by zero!"
                }
            }
            if result.text != "Division by zero!" {
                result.text = String(firstNumber.rounded())
            }
            print("= \(firstNumber.rounded())")
            firstNumber = 0
            neg = false
        }
    }
    
}


