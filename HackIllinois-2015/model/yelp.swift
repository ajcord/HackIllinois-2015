//
//  yelp.swift
//  HackIllinois-2015
//
//  Created by Alex Cordonnier on 2/27/15.
//  Copyright (c) 2015 PointOfIgnition. All rights reserved.
//

import Foundation

class YelpHelper {
    let yelp: YelpClient
    
    init() {
        self.yelp = YelpClient(consumerKey: "EWnG9z8IIVqjNBppkyPSrg",
            consumerSecret: "EfBGgpEol2GKud8I0Ha3g4RM0PU",
            accessToken: "Cq046mMmBib1uSdLOST7uPJ1F0-uV3xM",
            accessSecret: "4cMK75-mWB1yzHhT2SCYzCyYVKw")
    }
    
    func getFood() {
        yelp.searchWithTerm(term: "food", parameters: ["location": "Champaign, IL"],
            success: {
                (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                let results = (response["businesses"] as Array).map({
                    (business: NSDictionary) -> YelpBusiness in
                    return YelpBusiness(dictionary: business)
                })
            }, failure: {
                (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
            }
        )
    }
}

/*
import OAuthSwift


func doOAuthYelp(){
    let oauthswift = OAuth1Swift(
        consumerKey:    "EWnG9z8IIVqjNBppkyPSrg",
        consumerSecret: "EfBGgpEol2GKud8I0Ha3g4RM0PU",
        requestTokenUrl: "https://api.twitter.com/oauth/request_token",
        authorizeUrl:    "https://api.twitter.com/oauth/authorize",
        accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
    )
    
    oauthswift.webViewController = WebViewController()
    oauthswift.authorizeWithCallbackURL( NSURL(string: "oauth-swift://oauth-callback/yelp")!, success: {
        var parameters =  ["term": "food", "location": "Champaign, IL"]
        oauthswift.client.get("http://api.yelp.com/v2/search", parameters: parameters,
            success: {
                data, response in
                let jsonDict: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
                println(jsonDict)
            }, failure: {(error:NSError!) -> Void in
                println(error)
        })
        
        }, failure: {(error:NSError!) -> Void in
            println(error.localizedDescription)
        }
    )
}
*/