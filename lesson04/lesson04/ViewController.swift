//
//  ViewController.swift
//  lesson04
//
//  Created by David Reyes Pucheta on 07/09/15.
//  Copyright (c) 2015 David Reyes Pucheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var label: UILabel!

    @IBAction func changeLabel(sender: AnyObject) {
        label.text = "ive chabge you ...."
    }
}

