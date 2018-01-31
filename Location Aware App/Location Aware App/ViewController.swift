//
//  ViewController.swift
//  Finding the User
//
//  Created by Brett Goldfine on 7/27/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    var locationManager = CLLocationManager()
    
    var map = MKMapView()
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var nearestAddressLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        latitudeLabel.text = String(userLocation.coordinate.latitude)
        longitudeLabel.text = String(userLocation.coordinate.longitude)
        courseLabel.text = String(userLocation.speed)
        speedLabel.text = String(userLocation.course)
        altitudeLabel.text = String(userLocation.altitude)
        
        
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if error != nil {
                print(error)
            } else {
                if let placemark = placemarks?[0] {
                    
                    var subThroughfare = ""
                    if placemark.subThoroughfare != nil {
                        subThroughfare = placemark.subThoroughfare!
                    }
                    
                    var throughfare = ""
                    if placemark.thoroughfare != nil {
                        subThroughfare = placemark.thoroughfare!
                    }
                    
                    var subLocality = ""
                    if placemark.subLocality != nil {
                        subThroughfare = placemark.subLocality!
                    }
                    
                    var subAdministrativeArea = ""
                    if placemark.subAdministrativeArea != nil {
                        subThroughfare = placemark.subAdministrativeArea!
                    }
                    
                    var postalCode = ""
                    if placemark.postalCode != nil {
                        subThroughfare = placemark.postalCode!
                    }
                    
                    var country = ""
                    if placemark.country != nil {
                        subThroughfare = placemark.country!
                    }
                    self.nearestAddressLabel.text! = (subThroughfare + " " + throughfare + "\n" + subLocality + "\n" + subAdministrativeArea + "\n" + postalCode + "\n" + country)
                }
                
            }
        }//CLGeocoder

        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
}
    
    


