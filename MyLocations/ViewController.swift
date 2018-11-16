//
//  ViewController.swift
//  MyLocations
//
//  Created by iMac on 9/11/18.
//  Copyright © 2018 Ignasi Pérez. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var clLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    @IBOutlet weak var textLatitude: UILabel!
    @IBOutlet weak var textLongitude: UILabel!
    @IBOutlet weak var textHorizontalAccuracy: UILabel!
    
    @IBOutlet weak var textAltitude: UILabel!
    
    @IBOutlet weak var textVerticalAccuracy: UILabel!
    
    @IBOutlet weak var textDistance: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        clLocationManager.delegate = self
        startLocation = nil
    }


    
    @IBAction func resetDistancePressed(_ sender: Any) {
        startLocation = nil
    }
    
    
    @IBAction func startWhenInUsePressed(_ sender: Any) {
        clLocationManager.requestWhenInUseAuthorization()
        clLocationManager.startUpdatingLocation()
        clLocationManager.allowsBackgroundLocationUpdates = true
    }
    
    
    @IBAction func startAlwaysPressed(_ sender: Any) {
        clLocationManager.stopUpdatingLocation()
        clLocationManager.requestAlwaysAuthorization()
        clLocationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        let latestLocation: CLLocation = locations[locations.count - 1]
        
        textLatitude.text = String(format: "%.4f",
                                   latestLocation.coordinate.latitude)
        textLongitude.text = String(format: "%.4f",
                                    latestLocation.coordinate.longitude)
        textHorizontalAccuracy.text = String(format: "%.4f",
                                             latestLocation.horizontalAccuracy)
        textAltitude.text = String(format: "%.4f",
                                   latestLocation.altitude)
        textVerticalAccuracy.text = String(format: "%.4f",
                                           latestLocation.verticalAccuracy)
        
        if startLocation == nil {
            startLocation = latestLocation
        }
        
        let distanceBetween: CLLocationDistance =
            latestLocation.distance(from: startLocation)
        
        textDistance.text = String(format: "%.2f", distanceBetween)
        
        
        print("Latitude:  \(latestLocation.coordinate.latitude)")
        print("Longitude: \(latestLocation.coordinate.longitude)")
    }
    
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}

