//
//  FoodMapViewController.swift
//  HackIllinois-2015
//
//  Created by Brandon Groff on 2/28/15.
//  Copyright (c) 2015 PointOfIgnition. All rights reserved.
//

import UIKit
import MapKit

class FoodMapViewController : UIViewController {
    
    @IBOutlet weak var foodMap: MapsController!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline{
            println(overlay.title)
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            if(overlay.title == "Walk"){
                polylineRenderer.strokeColor = UIColor.blueColor()
            }
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    
    func addNewRoute(source: MKMapItem, destination: MKMapItem ){
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
                self.showRoute(response)
            }
        })
    }
    
    func showRoute(response: MKDirectionsResponse){
        for route in response.routes as [MKRoute]{
            foodMap.addOverlay(route.polyline,level:MKOverlayLevel.AboveRoads)
            // for step in route.steps{
            //   println(step.instructions)
            //}
        }
    }
    
    func addResteraunt(beginPoint: MKMapItem, endPoint: MKMapItem){
        addNewRoute(beginPoint,destination: endPoint)
        //foodMap.addAnnotation(endPoint)
    }
    
}