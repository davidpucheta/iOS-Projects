//
//  ViewController.swift
//  DogYears
//
//  Created by David Reyes Pucheta on 07/09/15.
//  Copyright (c) 2015 David Reyes Pucheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calculate(sender: AnyObject) {
        let humanAge = Int(ageTextField.text!)
        let dogyears = humanAge! * 7
        
        resultLabel.text = "The age of your dog is \(dogyears) in dog years."
    }

}

