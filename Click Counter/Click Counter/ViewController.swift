//
//  ViewController.swift
//  Click Counter
//
//  Created by David Reyes Pucheta on 17/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var count = 0
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func incrementCount() {
        self.count++
        self.label.text = "\(self.count)"
    }
    
    @IBAction func clickBtn(sender: UIButton, forEvent event: UIEvent) {
        incrementCount()
    }
    
}

