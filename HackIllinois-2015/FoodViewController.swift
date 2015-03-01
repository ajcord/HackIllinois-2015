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
        doSearch("burger")
        doSearch("taco")
        doSearch("pizza")
    }
    
    @IBAction func bugerButtonClick(sender: UIButton) {
        DinerChoices.typeChoice = "burger"
    }
    
    @IBAction func tacoButtonClick(sender: UIButton) {
        DinerChoices.typeChoice = "taco"
    }
    
    @IBAction func pizzaButtonClick(sender: UIButton) {
        DinerChoices.typeChoice = "pizza"
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
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) in
            self.updateDinerChoices(response.mapItems as [MKMapItem], foodType: foodType)
        }
    }
    
    func distance(a: CLLocationCoordinate2D, b: CLLocationCoordinate2D) -> Double {
        let latDist = a.latitude - b.latitude
        let longDist = a.longitude - b.longitude
        return sqrt(pow(latDist, 2) + pow(longDist, 2))
    }
    
    func updateDinerChoices(places: [MKMapItem], foodType: String) {
        var p = places
        let location = locationController.getLocation()
        p.sort({ self.distance($0.placemark.coordinate, b: location.coordinate) < self.distance($1.placemark.coordinate, b: location.coordinate) })
        if foodType == "burger" {
            DinerChoices.burgersPlaces = p
        } else if foodType == "taco" {
            DinerChoices.tacosPlaces = p
        } else if foodType  == "pizza" {
            DinerChoices.pizzaPlaces = p
        }
    }
    
}