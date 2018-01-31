//
//  MyGamesViewController.swift
//  Gamify Version 2
//
//  Created by Brett Goldfine on 8/1/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import CoreData

class MyGamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var gameNames: [String] = []
    var gameDescriptions: [String] = []
    var firstLevels: [NSManagedObject] = []
    var secondLevels: [NSManagedObject] = []
    var thirdLevels: [NSManagedObject] = []
    
    var activeRow = 0
    
    //Table Stuff
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return gameNames.count
    }
    
    //display game names on table cells
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = gameNames[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    //when a player clicks on a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activeRow = indexPath.row
        performSegue(withIdentifier: "toPlayLevel", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    //prepare for exchange of info
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPlayLevel" {
            
            let playLevelViewController = segue.destination as! PlayLevelViewController
            
            //send over name info
            playLevelViewController.gameName = gameNames[activeRow]
            playLevelViewController.gameDescription = gameDescriptions[activeRow]
            
            //set up levels
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let context = appDelegate.persistentContainer.viewContext
            
            let gameRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
            
            gameRequest.returnsObjectsAsFaults = false
            
            do {
                
                let games = try context.fetch(gameRequest) as! [Games]
                
                firstLevels = []
                secondLevels = []
                thirdLevels = []
                
                for level in games[activeRow].levelOne?.allObjects as! [NSManagedObject] {
                    
                    firstLevels.append(level)
                    
                }
                
                for level in games[activeRow].levelTwo?.allObjects as! [NSManagedObject] {
                    
                    secondLevels.append(level)
                    
                }
                
                for level in games[activeRow].levelThree?.allObjects as! [NSManagedObject] {
                    
                    thirdLevels.append(level)
                    
                }
            } catch {
                //couldnt attach levels
            }
            
            
            playLevelViewController.level1 = firstLevels
            playLevelViewController.level2 = secondLevels
            playLevelViewController.level3 = thirdLevels
            
        }
        
    }
    
    
    //delete a game if user requests from table, local, and core data
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            //extract core data and set restrictions for it to delete in core data
            //delete core data first because it must access local before deleted
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let context = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
            
            request.returnsObjectsAsFaults = false
            
            //delete core data and then save that
            do {
                
                let games = try context.fetch(request)
                
                context.delete(games[indexPath.row] as! NSManagedObject)
                
                do {
                    try context.save()
                }
                catch {
                    //process error
                }
                
            }
            catch {
                //cannot fetch data
            }
            
            //clear local variables for deleted cell, then reload table
            gameNames.remove(at: indexPath.row)
            gameDescriptions.remove(at: indexPath.row)
            
        }
        
        table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        self.table.backgroundColor = UIColor.lightGray
        //deleteCoreData()
        
        //extract core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let gameRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
        
        gameRequest.returnsObjectsAsFaults = false
        
        //set local arrays to equal values of extracted core data
        do {
            

            let results = try context.fetch(gameRequest)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let nameOfGame = result.value(forKey: "gameName") as? String {
                        gameNames.append(nameOfGame)
                    }
                    
                    if let nameOfDescription = result.value(forKey: "gameDescription") as? String {
                        gameDescriptions.append(nameOfDescription)
                    }
                    
                    }
                    
                }
                
                
                
            }
      
        catch {
            //cannot fetch data
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deleteCoreData() {
        // create the delete request for the specified entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Games")
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
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "LevelsOne")
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        
        // get reference to the persistent container
        let persistentContainer2 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        // perform the delete
        do {
            try persistentContainer2.viewContext.execute(deleteRequest2)
        } catch let error as NSError {
            print(error)
        }
        
        // create the delete request for the specified entity
        let fetchRequest3 = NSFetchRequest<NSFetchRequestResult>(entityName: "LevelsTwo")
        let deleteRequest3 = NSBatchDeleteRequest(fetchRequest: fetchRequest3)
        
        // get reference to the persistent container
        let persistentContainer3 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        // perform the delete
        do {
            try persistentContainer3.viewContext.execute(deleteRequest3)
        } catch let error as NSError {
            print(error)
        }
        
        // create the delete request for the specified entity
        let fetchRequest4 = NSFetchRequest<NSFetchRequestResult>(entityName: "LevelsThree")
        let deleteRequest4 = NSBatchDeleteRequest(fetchRequest: fetchRequest4)
        
        // get reference to the persistent container
        let persistentContainer4 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        // perform the delete
        do {
            try persistentContainer4.viewContext.execute(deleteRequest4)
        } catch let error as NSError {
            print(error)
        }
    }
    

}
