//
//  ChooseCityViewController.swift
//  Bucket List Lab Version 3
//
//  Created by Brett Goldfine on 8/13/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import CoreData

class ChooseCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cityNames: [String] = []
    var currentCityName = ""
    
    @IBOutlet weak var table: UITableView!
    
    //customize navigation bar
    override func viewDidAppear(_ animated: Bool) {
        
        let nav = self.navigationController?.navigationBar

        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.orange
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        if launchedBefore == false {

                //add core data
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                 
                 let context = appDelegate.persistentContainer.viewContext
                 
                 let newCategory = Categories(context: context)
                 
                 let newObjective = Objectives(context: context)
                 
                 //addCity(city: "Athens")
                 newCategory.setValue("Athens", forKey: "cityName")
                 newCategory.setValue("fun times ahead", forKey: "categoryName")
                 newCategory.setValue(false, forKey: "bought")
                 
                 newObjective.setValue("Athens", forKey: "cityName")
                 newObjective.setValue("fun times ahead", forKey: "categoryName")
                 newObjective.setValue(false, forKey: "achieved")
                 newObjective.setValue("first objective", forKey: "objectiveName")
                 newObjective.setValue("first description", forKey: "objectiveDescription")
                 newObjective.setValue(-83.37354599999998, forKey: "objectiveLon")
                 newObjective.setValue(33.963054 , forKey: "objectiveLat")
                 
                 
                 do {
                 try context.save()
                 
                 }
                 catch {
                 //process error
                 }
                
                UserDefaults.standard.set(true, forKey: "launchedBefore")
            }
        
        cityNames.append("Athens")
        
        self.table.backgroundColor = UIColor.lightGray
        
        table.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCity(city: String) {
        
        cityNames.append(city)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toChooseCategory" {
            
            let chooseCategoryViewController = segue.destination as! ChooseCategoryViewController
            
            chooseCategoryViewController.cityName = currentCityName
            
        }
        
        
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cityNames.count
        
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = cityNames[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.white

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currentCityName = cityNames[indexPath.row]
        performSegue(withIdentifier: "toChooseCategory", sender: self)
        
    }
    
    func deleteCoreData() {
        
        UserDefaults.standard.set(false, forKey: "launchedBefore")
        
        // create the delete request for the specified entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        // get reference to the persistent container
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        // perform the delete
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        
        // create the delete request for the specified entity
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Objectives")
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        
        // get reference to the persistent container
        let persistentContainer2 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        // perform the delete
        do {
            try persistentContainer2.viewContext.execute(deleteRequest2)
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
}
