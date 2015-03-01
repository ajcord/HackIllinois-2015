//
//  HomeViewController.swift
//  HackIllinois-2015
//
//  Created by Brandon Groff on 2/28/15.
//  Copyright (c) 2015 PointOfIgnition. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController : UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var homeMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad();
        homeMapView.showsUserLocation = true
        homeMapView.delegate = self //May be needed
        var a:CUMTDjson = CUMTDjson()
        
        let jsonDict = a.generateBusMap()
        if(jsonDict == NSDictionary()){
            //The error occured
            let alert = UIAlertController(title: "Failed to get MTD Data", message: "Turn your Icard around and call safe rides",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel,
                handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
            
        }
        parseJSONDict(jsonDict)
        //fatalError("init(coder:) has not been implemented")
        //mapView(this,
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline{
            println(overlay.title)
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            if(overlay.title == "Walk"){
                polylineRenderer.strokeColor = UIColor.blueColor()
            }
            else{
                var color:String = overlay.title!
                var rString:String = color.substringToIndex(advance(color.startIndex, 2))
                var gString:String = color.substringFromIndex(advance(color.startIndex,2)).substringToIndex(advance(color.startIndex,2))
                var bString:String = color.substringFromIndex(advance(color.startIndex,4)).substringToIndex(advance(color.startIndex,2))
                var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
                NSScanner(string: rString).scanHexInt(&r)
                NSScanner(string: gString).scanHexInt(&g)
                NSScanner(string: bString).scanHexInt(&b)
                polylineRenderer.strokeColor = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
            }
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    
    func addNewRoute(source: MKMapItem, destination: MKMapItem, color: String ){
        let request:MKDirectionsRequest = MKDirectionsRequest()
        request.setDestination(destination)
        request.setSource(source)
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request:request)
        
        directions.calculateDirectionsWithCompletionHandler({(response:MKDirectionsResponse!, error: NSError!) in
            if error != nil{
                //Handle error
                println("THERE'S AN ERROR")
            }
            else{
                self.showRoute(response, color: color)
            }
        })
    }
    func showRoute(response: MKDirectionsResponse, color: String){
        for route in response.routes as [MKRoute]{
            route.polyline.title = String(color)
            
            homeMapView.addOverlay(route.polyline,level:MKOverlayLevel.AboveRoads)
            // for step in route.steps{
            //   println(step.instructions)
            //}
        }
        
    }
    
    func parseJSONDict(jsonDict:NSDictionary){
        //println("running")
        // println(jsonDict)
        let itineraries = jsonDict["itineraries"] as NSArray
        let itinleg = itineraries[0] as NSDictionary
        let legs =  itinleg["legs"] as NSArray
        //println(jsonDict)
        //println(itineraries)
        println(legs)
        for i in 0...legs.count - 1 {
            let leg = legs[i] as NSDictionary
            if leg["type"] as NSString == "Walk" {
                
                let begin = (leg["walk"] as NSDictionary)["begin"] as NSDictionary
                // walk leg
                let end = (leg["walk"] as NSDictionary)["end"] as NSDictionary
                
                let beginlocation = CLLocationCoordinate2D(latitude: begin["lat"] as CLLocationDegrees, longitude: begin["lon"] as CLLocationDegrees)
                //CLLocationCoordinate2D(latitude: <#CLLocationDegrees#>, longitude: <#CLLocationDegrees#>)
                let endlocation = CLLocationCoordinate2D(latitude: end["lat"] as CLLocationDegrees, longitude: end["lon"] as CLLocationDegrees)
                //MKPlacemark(coordinate: <#CLLocationCoordinate2D#>, addressDictionary: <#[NSObject : AnyObject]!#>)
                let beginplacemark = MKPlacemark(coordinate: beginlocation, addressDictionary: nil)
                let endplacemark = MKPlacemark(coordinate:endlocation, addressDictionary: nil)
                let beginPoint = MKMapItem(placemark: beginplacemark)
                let endPoint = MKMapItem(placemark: endplacemark)
                addNewRoute(beginPoint,destination: endPoint, color: "Walk")
                homeMapView.addAnnotation(endplacemark)
                //CLLocationDegrees(Float)
                //MKCoordinateSpan(latitudeDelta: <#CLLocationDegrees#>, longitudeDelta: <#CLLocationDegrees#>)
                var deltaLon:CLLocationDegrees = CLLocationDegrees(0.05)
                var deltaLat = CLLocationDegrees(0.05)
                var span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: deltaLat, longitudeDelta: deltaLon)
                var region:MKCoordinateRegion = MKCoordinateRegion(center: beginlocation, span: span)
                homeMapView.setRegion(region,animated:true)
                
            } else {
                // service leg
                
                for _service in (leg["services"] as NSArray) {
                    let service = _service as NSDictionary
                    let begin = service["begin"] as NSDictionary
                    let end = service["end"] as NSDictionary
                    
                    let beginlocation = CLLocationCoordinate2D(latitude: begin["lat"] as CLLocationDegrees, longitude: begin["lon"] as CLLocationDegrees)
                    //CLLocationCoordinate2D(latitude: <#CLLocationDegrees#>, longitude: <#CLLocationDegrees#>)
                    let endlocation = CLLocationCoordinate2D(latitude: end["lat"] as CLLocationDegrees, longitude: end["lon"] as CLLocationDegrees)
                    //MKPlacemark(coordinate: <#CLLocationCoordinate2D#>, addressDictionary: <#[NSObject : AnyObject]!#>)
                    let beginplacemark = MKPlacemark(coordinate: beginlocation, addressDictionary: nil)
                    let endplacemark = MKPlacemark(coordinate:endlocation, addressDictionary: nil)
                    let beginPoint = MKMapItem(placemark: beginplacemark)
                    let endPoint = MKMapItem(placemark: endplacemark)
                    let color = (service["route"] as NSDictionary)["route_color"] as String
                    addNewRoute(beginPoint,destination: endPoint, color: color)
                    homeMapView.addAnnotation(endplacemark)
                }
                
            }
            
        }
        
        //var num:Float = SettingsKeys.homeLat.toFloat()!//Should never get none number
        
    }
    
}