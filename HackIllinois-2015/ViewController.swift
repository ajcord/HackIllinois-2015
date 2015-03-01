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
        self.setTitleText()
    }
    
    @IBAction func foodButtonClick(sender: UIButton) {
        
        
    }
    
    @IBAction func homeButtonClick(sender: UIButton) {
        var json:CUMTDjson = CUMTDjson()
        
    }
    
    func setTitleText(){
        var food:NSAttributedString = NSAttributedString(string: "Food", attributes: [
            NSForegroundColorAttributeName: (UIColor .whiteColor()) ,NSStrokeWidthAttributeName: -3, NSStrokeColorAttributeName : (UIColor .blackColor())
            ])
        var home:NSAttributedString = NSAttributedString(string: "Home", attributes: [
            NSForegroundColorAttributeName: (UIColor .whiteColor()) , NSStrokeWidthAttributeName: -3, NSStrokeColorAttributeName : (UIColor .blackColor())
            ])
        foodButton.setAttributedTitle(food, forState: UIControlState.Normal);
        homeButton.setAttributedTitle(home, forState: UIControlState.Normal);
    }

}

