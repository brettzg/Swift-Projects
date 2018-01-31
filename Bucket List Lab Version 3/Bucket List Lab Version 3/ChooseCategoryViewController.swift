//
//  ChooseCategoryViewController.swift
//  Bucket List Lab Version 3
//
//  Created by Brett Goldfine on 8/13/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import CoreData

class ChooseCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cityName: String = ""
    var categoryNames: [String] = []
    var bought: [Bool] = []
    var currentDownload = -1
    var categoryObjects: [NSManagedObject] = []

    @IBOutlet weak var table: UITableView!
    
    
    @IBAction func backToChooseCity(_ sender: Any) {
        
        performSegue(withIdentifier: "toChooseCity", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //extract core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let categoriesRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        
        categoriesRequest.predicate = NSPredicate(format: "cityName = %@", cityName)
        
        categoriesRequest.returnsObjectsAsFaults = false
        
        //set local arrays to equal values of extracted core data
        do {
            
            
            let results = try context.fetch(categoriesRequest)
            
            categoryObjects = results as! [NSManagedObject]
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let nameOfCategoryObjects = result.value(forKey: "categoryName") as? String {
                        categoryNames.append(nameOfCategoryObjects)
                    }
                    
                    if let boughtObjects = result.value(forKey: "bought") as? Bool {
                        bought.append(boughtObjects)
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
        
        return categoryNames.count
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //set up cell for
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChooseCategoryTableViewCell
        
        //category name label
        cell.categoryNameLabel.text = categoryNames[indexPath.row]
        
        currentDownload = indexPath.row
        
        //adding action for the button
        cell.downloadGameButton.addTarget(self, action: #selector(self.downloadGameButtonPressed(sender:)), for: .touchUpInside)
        
        //set bought to true if it is true
        if bought[indexPath.row] == true {
            
            cell.downloadGameButton.isHidden = true
        }
        
        return cell
        
        
    }
    
    
    func downloadGameButtonPressed(sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let buttonRow = sender.tag
        
        //set bought to true in data
        if bought[buttonRow] == false {
        
            categoryObjects[buttonRow].setValue(true, forKey: "bought")
            sender.isHidden = true
            bought[buttonRow] = true
            
        }
        
        table.reloadData()
        
        do {
            try context.save()
        }
        catch {
            
        }

    }
    
    internal override func viewDidAppear(_ animated: Bool) {
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currentDownload = indexPath.row
        performSegue(withIdentifier: "toObjectives", sender: self)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toObjectives" {
            
            //set up cityName and categoryName for objectives
            let objectivesViewController = segue.destination as! ObjectivesViewController
            
            objectivesViewController.cityName = self.cityName
            
            objectivesViewController.categoryName = categoryNames[currentDownload]
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
    
}
