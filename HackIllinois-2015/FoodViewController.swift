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
    
    var locationController: LocationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationController = LocationController()
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
        let location = locationController.updateLocation()
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = foodType
        request.region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) in
            self.updateDinerChoices(response.mapItems as [MKMapItem])
        }
    }
    
    func updateDinerChoices(places: [MKMapItem]) {
        println(places)
        var p = places
        let location = locationController.getLocation()
//        p.sort({ (($0.placemark as MKAnnotation).coordinate - location.coordinate) > (($1.placemark as MKAnnotation).coordinate - location.coordinate) })
        println(p[0])
    }
    
}