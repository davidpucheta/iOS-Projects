//
//  ViewController.swift
//  CalculadoraIMC
//
//  Created by David Reyes Pucheta on 14/11/15.
//  Copyright © 2015 David Reyes Pucheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var peso: UITextField!
    @IBOutlet weak var estatura: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        peso.delegate = self
        estatura.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldDidBeginEditing(textField: UITextField) {
        var punto:CGPoint
        punto = CGPointMake(0, textField.frame.origin.y - 50)
        self.scroll.setContentOffset(punto, animated: true)
    }
    
    @IBAction func textFieldDidEndEditing(textField: UITextField) {
        self.scroll.setContentOffset(CGPointZero, animated: true)
    }
    
    @IBAction func backgroundTap(sender: UIControl){
        peso.resignFirstResponder()
        estatura.resignFirstResponder()
    }
    
    @IBAction func textfielDoneediting(sender: UITextField) {
        sender.resignFirstResponder()
    }

    @IBAction func calcularIMC(sender: AnyObject) {
        var IMC:Double
        let pesoLocal:Double?
        pesoLocal = Double(self.peso.text!)!
        let estaturaLocal = Double(self.estatura.text!)!
        IMC = pesoLocal!/(estaturaLocal * estaturaLocal)
        print("Resultado = \(IMC)")
    }

}

