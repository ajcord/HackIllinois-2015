//
//  FoodViewController.swift
//  HackIllinois-2015
//
//  Created by Brandon Groff on 2/28/15.
//  Copyright (c) 2015 PointOfIgnition. All rights reserved.
//

import UIKit
import MapKit

class FoodViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func bugerButtonClick(sender: UIButton) {
        doSearch("burger")
    }
    
    @IBAction func tacoButtonClick(sender: UIButton) {
        doSearch("taco")
    }
    
    @IBAction func pizzaButtonClick(sender: UIButton) {
        doSearch("pizza")
    }
    
    @IBAction func crackedButtonClick(sender: UIButton) {
        
    }
    
    func doSearch(foodType: String) {
        //Get the location
        let locationController = LocationController()
        let location = locationController.getLocation()
        println(location)
        
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = foodType
//        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) in
            self.updateDinerChoices(response.mapItems as [MKMapItem])
        }
    }
    
    func updateDinerChoices(places: [MKMapItem]) {
        
    }
    
}