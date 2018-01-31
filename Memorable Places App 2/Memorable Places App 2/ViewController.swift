//
//  ViewController.swift
//  Memorable Places App 2
//
//  Created by Brett Goldfine on 7/27/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let uilpgr: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(gestureRecognizer:)))
        
        map.addGestureRecognizer(uilpgr)
        
        //show current location when adding location
        if activePlace == -1 {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
        else {
            //get place details to display on map when clicking on a place

            if places.count > activePlace {
                
                if let name = places[activePlace]["name"] {
                    
                    if let lat = places[activePlace]["lat"] {
                        
                        if let lon = places[activePlace]["lon"] {
                            
                            if let latitude = Double(lat) {
                                
                                if let longitude = Double(lon) {
                                    
                                    let span: MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
                                    
                                    let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                    
                                    let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
                                    
                                    self.map.setRegion(region, animated: true)
                                    
                                    let annotation: MKPointAnnotation = MKPointAnnotation()
                                    
                                    annotation.coordinate = coordinate
                                    annotation.title = name
                                    self.map.addAnnotation(annotation)
                                }
                                
                            }
                        
                        }
                    }

                }
            }
        
        }
    
    }
    
    func longPress(gestureRecognizer: UIGestureRecognizer) {
        
        //only add once per click
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = gestureRecognizer.location(in: self.map)
            
            let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            var title = ""
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                if error != nil {
                    print(error)
                } else {
                    
                    if let placemark = placemarks?[0] {
                    
                        if  placemark.subThoroughfare != nil {
                            title += placemark.subThoroughfare!
                        }
                    
                        if placemark.thoroughfare != nil {
                            title += placemark.thoroughfare!
                        }
                        
                        if title == "" {
                            
                            title = "Added \(NSDate())"
                            
                        }
                        
                        let annotation: MKPointAnnotation = MKPointAnnotation()
                        
                        annotation.coordinate = newCoordinate
                        annotation.title = title
                        
                        self.map.addAnnotation(annotation)
                        
                        places.append(["name":title,"lat": String(annotation.coordinate.latitude),"lon": String(annotation.coordinate.longitude)])
                        
                        UserDefaults.standard.set(places, forKey: "places")

                    }
                }
            })
            
            
            
                    }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

