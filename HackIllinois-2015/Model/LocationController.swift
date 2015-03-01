//
//  LocationController.swift
//  HackIllinois-2015
//
//  Created by Alex Cordonnier on 2/28/15.
//  Copyright (c) 2015 PointOfIgnition. All rights reserved.
//

import MapKit

public class LocationController {
    let locationManager: CLLocationManager!
    var mostRecentLocation: CLLocation!
    init() {
        if CLLocationManager.locationServicesEnabled() {
            println("Location services enabled")
            locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            println("Location services disabled")
        }
    }
    
    func getLocation() -> CLLocation {
        if mostRecentLocation != nil {
            return mostRecentLocation
        } else {
            return updateLocation()
        }
    }
    
    func updateLocation() -> CLLocation {
        if (locationManager.location != nil) {
            mostRecentLocation = locationManager.location
            return mostRecentLocation
        }
        
        //Wait for a location
        println("Waiting for location...")
        while locationManager.location == nil { }
        println("Got location: \(locationManager.location)")
        
        mostRecentLocation = locationManager.location
        return mostRecentLocation
    }
    
}