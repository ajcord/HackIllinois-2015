//
//  ViewController.swift
//  HackIllinois-2015
//
//  Created by Alex Cordonnier on 2/27/15.
//  Copyright (c) 2015 PointOfIgnition. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func foodButtonClick(sender: UIButton) {
        
        
    }
    
    @IBAction func homeButtonClick(sender: UIButton) {
        var json:CUMTDjson = CUMTDjson()
        
    }

}

