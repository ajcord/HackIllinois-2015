//
//  ViewController.swift
//  HackIllinois-2015
//
//  Created by Alex Cordonnier on 2/27/15.
//  Copyright (c) 2015 PointOfIgnition. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    @IBAction func click(sender: AnyObject) {
        let version = "v2.2"
        let format = "json"
        let method = "GetRoute"
        let key = "bc049e9f423e49e7946f069af686ca3d"
        let route_id = "GREEN"
        
        let url = NSURL(string: "https://developer.cumtd.com/api/\(version)/\(format)/\(method)?key=\(key)&route_id=\(route_id)")
        println(url)
        
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "GET"
        var session = NSURLSession.sharedSession()
        
        var error: NSError?
        
        //request.HTTPBody = NSJSONSerialization.dataWithJSONObject(data, options: nil, error: &error)
        
        var reponseError: NSError?
        var response: NSURLResponse?
        
        var urlData = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError) as NSData?

        
        if let httpResponse = response as NSHTTPURLResponse? {
            println("response code: \(httpResponse.statusCode)")
            let jsonDict = NSJSONSerialization.JSONObjectWithData(urlData!, options: nil, error: &error) as NSDictionary
            println((jsonDict["routes"] as NSArray)[0]["route_id"])
        } else {
            println("error")

        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

