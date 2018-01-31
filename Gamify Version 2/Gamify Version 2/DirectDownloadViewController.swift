//
//  DirectDownloadViewController.swift
//  Gamify Version 2
//
//  Created by Brett Goldfine on 8/10/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class DirectDownloadViewController: UIViewController {
    
    
    var gameName: String = ""
    var gameDescription: String = ""
    var level1: [Any] = []
    var level2: [Any] = []
    var level3: [Any] = []
    
    var goals: [String] = []
    var rewards: [String] = []
    var punishments: [String] = []
    var achievements: [String?] = []
    var achievementPictures: [UIImage?] = []
    
    
    @IBOutlet weak var gameNameLabel: UILabel!
    
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    
    //download game
    @IBAction func downloadGame(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newGame = Games(context: context)
        
        newGame.setValue(gameName, forKey: "gameName")
        newGame.setValue(gameDescription, forKey: "gameDescription")
        
        
        do {
            try context.save()
            
        }
        catch {
            //process error
        }
        
        
        if level1.count > 0 {
            goals = level1[0] as! [String]
            rewards = level1[1] as! [String]
            punishments = level1[2] as! [String]
            achievements = level1[3] as! [String?]
            achievementPictures = level1[4] as! [UIImage?]
            
            var currentGoal = 0
            
            //set up based on number of objects
            for objectNumber in 0...(goals.count - 1) {
                
                let newLevel1 = LevelsOne(context: context)
                
                newLevel1.setValue(goals[objectNumber], forKey: "goal")
                newLevel1.setValue(rewards[objectNumber], forKey: "reward")
                newLevel1.setValue(punishments[objectNumber], forKey: "punishment")
                newLevel1.setValue(achievements[objectNumber], forKey: "achievement")
                
                if let image = achievementPictures[objectNumber] {
                    let imageData: NSData = UIImagePNGRepresentation(image)! as NSData
                    newLevel1.setValue(imageData, forKey: "achievementIcon")
                    
                } else {
                    newLevel1.setValue(nil, forKey: "achievementIcon")
                }
                
                newLevel1.setValue(false, forKey: "achieved")
                newLevel1.setValue(currentGoal , forKey: "goalNumber")
                
                currentGoal += 1
                
                newLevel1.gameOne = newGame
                
            }
            
            
            do {
                try context.save()
                
            }
            catch {
                //process error
            }
            
        }//level 1
        
        
        if level2.count > 0 {
            goals = level2[0] as! [String]
            rewards = level2[1] as! [String]
            punishments = level2[2] as! [String]
            achievements = level2[3] as! [String?]
            achievementPictures = level2[4] as! [UIImage?]
            
            var currentGoal = 0
            
            //set up based on number of objects
            for objectNumber in 0...(goals.count - 1) {
                
                let newLevel2 = LevelsTwo(context: context)
                
                newLevel2.setValue(goals[objectNumber], forKey: "goal")
                newLevel2.setValue(rewards[objectNumber], forKey: "reward")
                newLevel2.setValue(punishments[objectNumber], forKey: "punishment")
                newLevel2.setValue(achievements[objectNumber], forKey: "achievement")
                
                if let image = achievementPictures[objectNumber] {
                    let imageData: NSData = UIImagePNGRepresentation(image)! as NSData
                    newLevel2.setValue(imageData, forKey: "achievementIcon")
                    
                } else {
                    newLevel2.setValue(nil, forKey: "achievementIcon")
                }
                
                newLevel2.setValue(false, forKey: "achieved")
                newLevel2.setValue(currentGoal , forKey: "goalNumber")
                
                currentGoal += 1
                
                newLevel2.gameTwo = newGame
                
            }
            
            
            do {
                try context.save()
                
            }
            catch {
                //process error
            }
            
        }//level 2
        
        if level3.count > 0 {
            goals = level3[0] as! [String]
            rewards = level3[1] as! [String]
            punishments = level3[2] as! [String]
            achievements = level3[3] as! [String?]
            achievementPictures = level3[4] as! [UIImage?]
            
            var currentGoal = 0
            
            //set up based on number of objects
            for objectNumber in 0...(goals.count - 1) {
                
                let newLevel3 = LevelsThree(context: context)
                
                newLevel3.setValue(goals[objectNumber], forKey: "goal")
                newLevel3.setValue(rewards[objectNumber], forKey: "reward")
                newLevel3.setValue(punishments[objectNumber], forKey: "punishment")
                newLevel3.setValue(achievements[objectNumber], forKey: "achievement")
                
                if let image = achievementPictures[objectNumber] {
                    let imageData: NSData = UIImagePNGRepresentation(image)! as NSData
                    newLevel3.setValue(imageData, forKey: "achievementIcon")
                    
                } else {
                    newLevel3.setValue(nil, forKey: "achievementIcon")
                }
                
                newLevel3.setValue(false, forKey: "achieved")
                newLevel3.setValue(currentGoal , forKey: "goalNumber")
                
                currentGoal += 1
                
                newLevel3.gameThree = newGame
                
            }
            
            
            do {
                try context.save()
                
            }
            catch {
                //process error
            }
            
        }//level 3
        
        performSegue(withIdentifier: "toMainViewController", sender: self)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        gameNameLabel.text = gameName
        gameDescriptionLabel.text = gameDescription
        self.view.backgroundColor = UIColor.lightGray
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
