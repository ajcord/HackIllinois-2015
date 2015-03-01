//
//  SettingsViewController.swift
//  HackIllinois-2015
//
//  Created by Brandon Groff on 2/28/15.
//  Copyright (c) 2015 PointOfIgnition. All rights reserved.
//

import UIKit
import MapKit

class SettingsViewController : UIViewController, UITextFieldDelegate {
    
    var latitude:Double = 0.0;
    var longitude:Double = 0.0;
    var address:NSString = "";
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressStatusLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.loadSettings()
        addressStatusLabel.hidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addressTextField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.validateAddress(textField.text);
    }    
    
    @IBAction func saveSettingsClick(sender: UIBarButtonItem) {
        let status: NSString = addressStatusLabel.text!;
        if (status.isEqualToString("Address found!")){
            self.saveSettings();
            savePopUp("Settings saved!");
        } else {
            savePopUp("Settings could not be saved!");
        }
    }
    
    func loadSettings(){
        print("Loading settings...")
        if(self.settingsAlreadySet()){
            print("Settings found!")
            self.addressTextField.placeholder = NSUserDefaults.standardUserDefaults().stringForKey("homeAddress");
        } else {
            print("Settings not found!")
            self.addressTextField.placeholder = SettingsKey.defaultHomeAddress;
        }
    }
    
    func settingsAlreadySet()->Bool {
        if (nil == NSUserDefaults.standardUserDefaults().stringForKey("homeAddress")?.hashValue){
            return false;
        }
        var latitude:Double = NSUserDefaults.standardUserDefaults().doubleForKey("latitude");
        var longitude:Double = NSUserDefaults.standardUserDefaults().doubleForKey("longitude");
        var address:String = NSUserDefaults.standardUserDefaults().stringForKey("homeAddress")!;
        if (latitude == 0.0){
            return false;
        } else if (longitude == 0.0){
            return false;
        } else if((address.isEmpty)) {
            return false;
        } else {
           return true;
        }
        
    }
    
    func saveSettings(){
        println(self.latitude);
        println(self.longitude);
        println(self.address);
        NSUserDefaults.standardUserDefaults().setDouble(self.latitude, forKey: "latitude");
        NSUserDefaults.standardUserDefaults().setDouble(self.longitude, forKey: "longitude");
        NSUserDefaults.standardUserDefaults().setValue(self.address as String, forKey: "homeAddress");
    }
    
    func validateAddress(address: NSString)->Void {
        var request = MKLocalSearchRequest()
        request.naturalLanguageQuery = address
        
        let localSearch: MKLocalSearch = MKLocalSearch(request: request)
        localSearch.startWithCompletionHandler { (response: MKLocalSearchResponse!, error: NSError!) -> Void in
            if (error == nil) {
                if response.mapItems.count == 0 {
                    self.addressStatusLabel.text = "Address not found!";
                    //NSException()
                } else {
                    let loc = response.mapItems[0] as MKMapItem
                    self.latitude = loc.placemark.location.coordinate.latitude as Double;
                    self.longitude = loc.placemark.location.coordinate.longitude as Double;
                    
                    let delimiters: NSCharacterSet = NSCharacterSet(charactersInString: ",@");
                    var addressArray = loc.placemark.description
                        .componentsSeparatedByCharactersInSet(delimiters);
                    var homeAddress = addressArray[1] + "," + addressArray[2];
                    homeAddress += "," + addressArray[3] + "," + addressArray[4];
                    
                    self.address = homeAddress;
                    self.addressStatusLabel.text = "Address found!";
                }
            } else {
                self.addressStatusLabel.text = "Address not found!";
                println(error)
            }
            self.addressStatusLabel.hidden = false
        }
        return;
    }
    
    func savePopUp(title: NSString) {
        
        let alert = UIAlertController(title: title, message: "Settings saved!",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel,
            handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}