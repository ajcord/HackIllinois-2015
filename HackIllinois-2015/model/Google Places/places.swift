//
//  places.swift
//  HackIllinois-2015
//
//  Created by Alex Cordonnier on 2/28/15.
//  Copyright (c) 2015 PointOfIgnition. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class GooglePlaces {
    
    let base_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    
    func search(
        location: CLLocationCoordinate2D,
        radius: Int,
        query: String,
        callback: (items: [MKMapItem]?, errorDescription: String?) -> Void) {
            
            var urlEncodedQuery = query.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            var url = NSURL(string: "\(base_url)?location=\(location.latitude),\(location.longitude)&radius=\(radius)&key=\(apikey)&name=\(urlEncodedQuery!)")
            
            var session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            session.dataTaskWithURL(url!, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                
                if error != nil {
                    callback(items: nil, errorDescription: error.localizedDescription)
                }
                
                if let statusCode = response as? NSHTTPURLResponse {
                    if statusCode.statusCode != 200 {
                        callback(items: nil, errorDescription: "Google Places: Error \(statusCode)")
                    }
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    callback(items: GooglePlaces.parseFromData(data), errorDescription: nil)
                })
                
            }).resume()
            
    }
    
    class func parseFromData(data : NSData) -> [MKMapItem] {
        var mapItems = [MKMapItem]()
        
        var json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        var results = json["results"] as? Array<NSDictionary>
        println("results = \(results!.count)")
        
        for result in results! {
            
            var name = result["name"] as String
            
            var coordinate : CLLocationCoordinate2D!
            
            if let geometry = result["geometry"] as? NSDictionary {
                if let location = geometry["location"] as? NSDictionary {
                    var lat = location["lat"] as CLLocationDegrees
                    var long = location["lng"] as CLLocationDegrees
                    coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    
                    var placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
                    var mapItem = MKMapItem(placemark: placemark)
                    mapItem.name = name
                    mapItems.append(mapItem)
                }
            }
        }
        
        return mapItems
    }
    
}