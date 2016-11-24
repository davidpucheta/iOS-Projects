//
//  ViewController.swift
//  Experiment
//
//  Created by David Reyes Pucheta on 18/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
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
    
    @IBAction func presentBtn(sender: AnyObject) {
        
        let nextController = UIImagePickerController()
        self.presentViewController(nextController, animated: true, completion: nil)
        
        
    }
    
    


}

