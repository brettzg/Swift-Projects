//
//  SingleObjectiveViewController.swift
//  Bucket List Lab Version 3
//
//  Created by Brett Goldfine on 8/17/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Social

class SingleObjectiveViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var cityName = ""
    var categoryName = ""
    
    var objectiveName = ""
    var objectiveDescription = ""
    var objectiveLat = 0.0
    var objectiveLon = 0.0
    
    var currentImage: UIImage? = nil

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()

    
    @IBAction func backToObjectives(_ sender: Any) {
        
        performSegue(withIdentifier: "toObjectives", sender: self)
        
    }
    
    @IBAction func chooseShareImage(_ sender: Any) {
        
        currentImage = nil
        
        //add image
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //after it is complete
        }
        
    }
    
    @IBAction func sharePost(_ sender: Any) {
        
        let alert = UIAlertController(title: "Share", message: "Share with friends!", preferredStyle: .actionSheet)
        
        //first action
        let actionOne = UIAlertAction(title: "Share on Facebook", style: .default) { (action) in
            
            let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
            
            post.setInitialText("Another one! I just did \(self.objectiveName) with my BuckIt Iphone app")
            
            
            
            if self.currentImage != nil {
                
                post.add(self.currentImage)
                self.currentImage = nil
            }
            
            self.present(post, animated: true, completion: nil)
            
            
        }
        
        //second action
        let actionTwo = UIAlertAction(title: "Share on Twitter", style: .default) { (action) in
            
            let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
            
            post.setInitialText("Another one! I just did \(self.objectiveName) with my BuckIt Iphone app")
            
            if self.currentImage != nil {
                
                post.add(self.currentImage)
                self.currentImage = nil
            }
            
            self.present(post, animated: true, completion: nil)
            
            
            
        }
        
        let actionThree = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //add action to action sheet
        alert.addAction(actionOne)
        alert.addAction(actionTwo)
        alert.addAction(actionThree)
        
        //present alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    //called after user picks image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            currentImage = image
            
        } else {
            
            currentImage = nil
            //error
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //style
        self.view.backgroundColor = UIColor.lightGray
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        nameLabel.text = objectiveName
        descriptionLabel.text = objectiveDescription
        
        let latitude: CLLocationDegrees = objectiveLat
        
        let longitude: CLLocationDegrees = objectiveLon
        
        let latDelta: CLLocationDegrees = 0.05
        
        let lonDelta: CLLocationDegrees = 0.05
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.title = objectiveName
        
        annotation.coordinate = location
        
        map.addAnnotation(annotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toObjectives" {
            
            let objectivesViewController = segue.destination as! ObjectivesViewController
            
            objectivesViewController.cityName = self.cityName
            
            objectivesViewController.categoryName = self.categoryName
            
        }
        
        
    }
    

}
