//
//  ViewController.swift
//  summ
//
//  Created by Dmitriy Roytman on 14.10.15.
//  Copyright © 2015 Dmitriy Roytman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var caluclateButton: UIButton!
    @IBOutlet weak var eTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var zTextField: UITextField!
    
    // MARK: - @IBAction
    @IBAction func onButtonClick(sender: AnyObject) {
        guard let e = eTextField.text where !e.isEmpty else {
            log("You must enter 'ξ' value first.")
            return
        }
        guard let zString = zTextField.text where !zString.isEmpty else {
            log("You must enter 'z' value first.")
            return
        }
        let eps = (e as NSString).doubleValue
        z = 2 + (zString as NSString).doubleValue
        calculate(eps)
        z = 2 + 0.1
        calculate(0.0001)
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Helper
    var factorialArray: [Int] = []
    var zPowerArray: [Double] = []
    var z: Double!
    func getNextFactorial() -> Int {
        let i = getCurrentFactorial()
        let result = i*(i+1)
        factorialArray.append(result)
        return result
    }
    
    func getCurrentFactorial() -> Int {
        return factorialArray.last!
    }
    
    func getNextZPower() -> Double {
        let last = zPowerArray.last!
        let next = z * last
        zPowerArray.append(next)
        return next
    }
    
    func calculate(eps: Double) -> Double {
        factorialArray = [1,2]
        zPowerArray = [2]
        var i = 2
        var value = eps + 1
        var result: Double = 0
        while abs(value) > eps {
            let firstAdd = getNextZPower()
            let del = NSNumber(integer: getNextFactorial()).doubleValue
            let secondAdd = NSNumber(integer: (i - 1)).doubleValue - z
            value = (firstAdd * secondAdd) / del
            result = result + value
            print("\(i-1): \(result)")
            i++
            if i > 1000 { break }
        }
        
        return result
    }
    func log(m: String) {
        log(m, append: false)
    }
    func log(m: String, append: Bool) {
        if !append { textView.text = "" }
        textView.text = m
    }
}

