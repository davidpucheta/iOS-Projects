//
//  ViewController.swift
//  1 Hour Swift tutorial
//
//  Created by David Reyes Pucheta on 25/09/15.
//  Copyright © 2015 David Reyes Pucheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var intNumber : Int = 0
    var doubleDecimal : Double = 0.23
    var doubleFloa : Float = -233.3
    var stringName : String = "David Reyes"
    var isBoolean : Bool = false

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var btnButton: UIButton!
    @IBOutlet weak var txtNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnButtonAction(sender: UIButton) {
        intNumber = Int(txtNumber.text!)!
        changeText()
    }
    
    func changeText (){
        lbl.text = "\(intNumber)"
        btnButton.setTitle("\(intNumber)", forState: UIControlState.Normal)
    }
    
    func changeTextAtStart (){
        lbl.text = "Start"
        btnButton.setTitle("Start text", forState: UIControlState.Normal)
    }

}

