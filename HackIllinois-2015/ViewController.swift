//
//  ViewController.swift
//  HackIllinois-2015
//
//  Created by Alex Cordonnier on 2/27/15.
//  Copyright (c) 2015 PointOfIgnition. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

<<<<<<< HEAD
class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
=======
class ViewController: UIViewController {

    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
>>>>>>> c6ff81c8a26c700e964197be8aaa0f97f53819f5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if CLLocationManager.locationServicesEnabled() {
            println("Location services enabled")
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            println("Location services disabled")
        }
        
        let gplaces = GooglePlaces()
        //Wait for a location
        println("waiting on location...")
        while locationManager.location == nil {
            
        }
        println("got location: \(locationManager.location)")
        gplaces.search(
            locationManager.location.coordinate,
            radius: 5000,
            query: "food") {
                (items, errorDescription) -> Void in
                if errorDescription != nil {
                    println("Error: \(errorDescription)")
                } else {
                    println("Result count: \(items!.count)")
                    for index in 0..<items!.count {
                        println([items![index].name])
                    }
                }
        }
    }
    
    @IBAction func foodButtonClick(sender: UIButton) {
        
        
    }
    
    @IBAction func homeButtonClick(sender: UIButton) {
        
    }
<<<<<<< HEAD
    
=======

>>>>>>> c6ff81c8a26c700e964197be8aaa0f97f53819f5
}

