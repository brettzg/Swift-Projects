//
//  ObjectivesViewController.swift
//  Bucket List Lab Version 3
//
//  Created by Brett Goldfine on 8/13/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import CoreData

class ObjectivesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var cityName: String = ""
    var categoryName: String = ""
    var objectiveNames: [String] = []
    var objectiveDescriptions: [String] = []
    var objectiveLats: [Double] = []
    var objectiveLons: [Double] = []
    var achieved: [Bool] = []
    var activeRow = 0
    
    var objectiveObjects: [NSManagedObject] = []

    @IBAction func backToChooseCategory(_ sender: Any) {
        
        performSegue(withIdentifier: "toChooseCategory", sender: self)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //send over name info
        
        
        //extract core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let objectivesRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Objectives")
        
        //set up objectives for certain predicate and city
        let cityPredicate = NSPredicate(format: "cityName = %@", cityName)
        let categoryPredicate = NSPredicate(format: "categoryName = %@", categoryName)
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [cityPredicate, categoryPredicate])
        
        objectivesRequest.predicate = compound
        
        objectivesRequest.returnsObjectsAsFaults = false
        
        //set local arrays to equal values of extracted core data
        do {
            
            let objectives = try context.fetch(objectivesRequest)
            
            objectiveObjects = objectives as! [NSManagedObject]
            
            if objectives.count > 0 {
                
                //append all objects from core data to array
                for object in objectives as! [NSManagedObject] {
                    
                    if let objectName = object.value(forKey: "objectiveName") as? String {
                        
                        objectiveNames.append(objectName)
                        
                    }
                    
                    if let objectDescription = object.value(forKey: "objectiveDescription") as? String {
                        
                        objectiveDescriptions.append(objectDescription)
                        
                    }
                    
                    if let objectLat = object.value(forKey: "objectiveLat") as? Double {
                        
                        objectiveLats.append(objectLat)
                        
                    }
                    
                    if let objectLon = object.value(forKey: "objectiveLon") as? Double {
                        
                        objectiveLons.append(objectLon)
                        
                    }
                    
                    if let objectAchieved = object.value(forKey: "achieved") as? Bool {
                        
                        achieved.append(objectAchieved)
                        
                    }
                    
                }
                
            }
            
            
        }
            
        catch {
            //cannot fetch data
        }
        
        self.table.backgroundColor = UIColor.lightGray

        
        table.reloadData()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objectiveNames.count
        
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ObjectivesTableViewCell
        
        //custom cell stuff
        cell.objectiveLabel.text = self.objectiveNames[indexPath.row]
        
        cell.achievedButton.tag = indexPath.row
        
        cell.achievedButton.addTarget(self, action: #selector(self.achievedButtonPressed(sender:)), for: .touchUpInside)
        
        if achieved[indexPath.row] == false {
            
            cell.achievedButton.setImage(UIImage(named: "Box.png"), for: [])
            
        }
        else if achieved[indexPath.row] == true {
            
            cell.achievedButton.setImage(UIImage(named: "CheckBox.png"), for: [])
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activeRow = indexPath.row
        performSegue(withIdentifier: "toObjectiveDescription", sender: self)
        
    }
    
    func achievedButtonPressed(sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let buttonRow = sender.tag
        
        //set achieved to true in data and change box to check or vice versa
        if achieved[buttonRow] == false {
            
            achieved[buttonRow] = true
            sender.setImage(UIImage(named: "checkBox.png"), for: [])
            
            objectiveObjects[buttonRow].setValue(true, forKey: "achieved")

            
        } else {
            
            achieved[buttonRow] = false
            sender.setImage(UIImage(named: "Box.png"), for: [])
            
            objectiveObjects[buttonRow].setValue(false, forKey: "achieved")
            
        }
        
        do {
            try context.save()
        }
        catch {
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toChooseCategory" {
            
            let chooseCategoryViewController = segue.destination as! ChooseCategoryViewController
            
            chooseCategoryViewController.cityName = self.cityName
        }
        
        if segue.identifier == "toObjectiveDescription" {
            
            let singleObjectiveViewController = segue.destination as! SingleObjectiveViewController
            
            singleObjectiveViewController.cityName = self.cityName
            singleObjectiveViewController.categoryName = self.categoryName
            
            singleObjectiveViewController.objectiveName = objectiveNames[activeRow]
            singleObjectiveViewController.objectiveDescription = objectiveDescriptions[activeRow]
            singleObjectiveViewController.objectiveLat = objectiveLats[activeRow]
            singleObjectiveViewController.objectiveLon = objectiveLons[activeRow]
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
}
