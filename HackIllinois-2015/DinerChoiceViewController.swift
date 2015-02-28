//
//  DinerChoiceViewController.swift
//  HackIllinois-2015
//
//  Created by Brandon Groff on 2/28/15.
//  Copyright (c) 2015 PointOfIgnition. All rights reserved.
//

import UIKit
import MapKit

class DinerChoiceViewController : UIViewController {
    
    var options: [MKMapItem]!
    
    @IBOutlet var locationButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func locationClick(sender: UIButton) {
        
    }
    
}