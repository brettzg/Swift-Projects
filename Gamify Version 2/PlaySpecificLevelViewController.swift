//
//  PlaySpecificLevelViewController.swift
//  Gamify Version 2
//
//  Created by Brett Goldfine on 8/2/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import CoreData

class PlaySpecificLevelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //variables for game
    var gameText = ""
    var gameDescription = ""
    var level1: [NSManagedObject] = []
    var level2: [NSManagedObject] = []
    var level3: [NSManagedObject] = []
    var currentLevel = 0
    
    var goals: [String] = []
    var rewards: [String] = []
    var punishments: [String] = []
    var achievements: [String?] = []
    var achievementPictures: [UIImage?] = []
    var achieved: [Bool] = []
    var goalNumber: [Int] = []
    
    var activeRow = 0
    
    @IBOutlet weak var table: UITableView!

    
    @IBAction func backToPlaya(_ sender: Any) {
        performSegue(withIdentifier: "toPlayLevel", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.lightGray
        self.table.backgroundColor = UIColor.lightGray
        
        //level one set up
        if currentLevel == 1 {
                
                for object in level1 {
                    
                    if let goalName = object.value(forKey: "goal") as? String {
                        goals.append(goalName)
                    }
                    
                    if let rewardName = object.value(forKey: "reward") as? String {
                        rewards.append(rewardName)
                    }
                    
                    if let punishmentName = object.value(forKey: "punishment") as? String {
                        punishments.append(punishmentName)
                    }
                    
                    if let achievementName = object.value(forKey: "achievement") as? String {
                        achievements.append(achievementName)
                    } else {
                        achievements.append(nil)
                    }
                    
                    if let achievementIconName = object.value(forKey: "achievementIcon") as? NSData {
                        
                        if let data = achievementIconName as NSData! {
                            let myImage = UIImage(data: data as Data)
                            achievementPictures.append(myImage)
                        } else {
                            achievementPictures.append(nil)
                        }
                    }
                    
                    if let achievedName = object.value(forKey: "achieved") as? Bool {
                        achieved.append(achievedName)
                    }
                    
                    if let goalNumberName = object.value(forKey: "goalNumber") as? Int {
                        goalNumber.append(goalNumberName)
                    }
                }
                
                //resort arrays
                goals = sortArray(array1: goalNumber, array2: goals) as! [String]
                rewards = sortArray(array1: goalNumber, array2: rewards) as! [String]
                punishments = sortArray(array1: goalNumber, array2: punishments) as! [String]
                achievements = sortArray(array1: goalNumber, array2: achievements) as! [String?]
                achievementPictures = sortArray(array1: goalNumber, array2: achievementPictures) as! [UIImage?]
                achieved = sortArray(array1: goalNumber, array2: achieved) as! [Bool]
                goalNumber = goalNumber.sorted()
            
        }
       
        //level two set up
        if currentLevel == 2 {
            
            for object in level2 {
                
                if let goalName = object.value(forKey: "goal") as? String {
                    goals.append(goalName)
                }
                
                if let rewardName = object.value(forKey: "reward") as? String {
                    rewards.append(rewardName)
                }
                
                if let punishmentName = object.value(forKey: "punishment") as? String {
                    punishments.append(punishmentName)
                }
                
                if let achievementName = object.value(forKey: "achievement") as? String {
                    achievements.append(achievementName)
                } else {
                    achievements.append(nil)
                }
                
                if let achievementIconName = object.value(forKey: "achievementIcon") as? NSData {
                    
                    if let data = achievementIconName as NSData! {
                        let myImage = UIImage(data: data as Data)
                        achievementPictures.append(myImage)
                    } else {
                        achievementPictures.append(nil)
                    }
                }
                
                if let achievedName = object.value(forKey: "achieved") as? Bool {
                    achieved.append(achievedName)
                }
                
                if let goalNumberName = object.value(forKey: "goalNumber") as? Int {
                    goalNumber.append(goalNumberName)
                }
            }
            
            //resort arrays
            goals = sortArray(array1: goalNumber, array2: goals) as! [String]
            rewards = sortArray(array1: goalNumber, array2: rewards) as! [String]
            punishments = sortArray(array1: goalNumber, array2: punishments) as! [String]
            achievements = sortArray(array1: goalNumber, array2: achievements) as! [String?]
            achievementPictures = sortArray(array1: goalNumber, array2: achievementPictures) as! [UIImage?]
            achieved = sortArray(array1: goalNumber, array2: achieved) as! [Bool]
            goalNumber = goalNumber.sorted()
            
        }

        //level three set up
        if currentLevel == 3 {
            
            for object in level3 {
                
                if let goalName = object.value(forKey: "goal") as? String {
                    goals.append(goalName)
                }
                
                if let rewardName = object.value(forKey: "reward") as? String {
                    rewards.append(rewardName)
                }
                
                if let punishmentName = object.value(forKey: "punishment") as? String {
                    punishments.append(punishmentName)
                }
                
                if let achievementName = object.value(forKey: "achievement") as? String {
                    achievements.append(achievementName)
                } else {
                    achievements.append(nil)
                }
                
                if let achievementIconName = object.value(forKey: "achievementIcon") as? NSData {
                    
                    if let data = achievementIconName as NSData! {
                        let myImage = UIImage(data: data as Data)
                        achievementPictures.append(myImage)
                    } else {
                        achievementPictures.append(nil)
                    }
                }
                
                if let achievedName = object.value(forKey: "achieved") as? Bool {
                    achieved.append(achievedName)
                }
                
                if let goalNumberName = object.value(forKey: "goalNumber") as? Int {
                    goalNumber.append(goalNumberName)
                }
            }
            
            //resort arrays
            goals = sortArray(array1: goalNumber, array2: goals) as! [String]
            rewards = sortArray(array1: goalNumber, array2: rewards) as! [String]
            punishments = sortArray(array1: goalNumber, array2: punishments) as! [String]
            achievements = sortArray(array1: goalNumber, array2: achievements) as! [String?]
            achievementPictures = sortArray(array1: goalNumber, array2: achievementPictures) as! [UIImage?]
            achieved = sortArray(array1: goalNumber, array2: achieved) as! [Bool]
            goalNumber = goalNumber.sorted()
            
        }
        
        table.reloadData()
        
        
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Table Stuff
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PlaySpecificLevelTableViewCell
        
        //custom cell stuff
        cell.goalNameLabel.text = self.goals[indexPath.row]
        
        cell.achievedButton.tag = indexPath.row
        
        cell.achievedButton.addTarget(self, action: #selector(self.achievedButtonPressed(sender:)), for: .touchUpInside)
        
        if achieved[indexPath.row] == false {
            
            cell.achievedButton.setImage(UIImage(named: "Box.png"), for: [])
            
        }
        else if achieved[indexPath.row] == true {
            
            cell.achievedButton.setImage(UIImage(named: "CheckBox.png"), for: [])
        }
        
        cell.textLabel?.textColor = UIColor.white
   
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func achievedButtonPressed(sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let buttonRow = sender.tag
        
        //set achieved to true in data and change box to check or vice versa
        if achieved[buttonRow] == false {
            
            achieved[buttonRow] = true
            sender.setImage(UIImage(named: "checkBox.png"), for: [])
            
            if currentLevel == 1 {
                level1[buttonRow].setValue(true, forKey: "achieved")
            }
            else if currentLevel == 2 {
                level2[buttonRow].setValue(true, forKey: "achieved")
            }
            else if currentLevel == 3 {
                level3[buttonRow].setValue(true, forKey: "achieved")
            }
            
        } else {
            
            achieved[buttonRow] = false
            sender.setImage(UIImage(named: "Box.png"), for: [])

            if currentLevel == 1 {
                level1[buttonRow].setValue(false, forKey: "achieved")
            }
            else if currentLevel == 2 {
                level2[buttonRow].setValue(false, forKey: "achieved")
            }
            else if currentLevel == 3 {
                level3[buttonRow].setValue(false, forKey: "achieved")
            }
            
        }
        
        do {
            try context.save()
        }
        catch {
            
        }
        
    }
    
    //send over information and access goal when clicked and perform segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activeRow = indexPath.row
        performSegue(withIdentifier: "toGoalInfoViewController", sender: self)
        
    }
    
    //prepares for segue and sends over all relevant info
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //if moving to choose level view controller
        if segue.identifier == "toGoalInfoViewController" {
            
            let goalInfoViewController = segue.destination as! GoalInfoViewController
            
            //sends over goal for description
            goalInfoViewController.sentGoalDescription = goals[activeRow]
            goalInfoViewController.sentRewardDescription = rewards[activeRow]
            goalInfoViewController.sentPunishmentDescription = punishments[activeRow]
            
            //adds descriptions if icon and achievement aren't nil
            //may want to change later
            if achievements[activeRow] != nil && achievementPictures[activeRow] != nil
            {
                goalInfoViewController.sentAchievementDescription = achievements[activeRow]!
                goalInfoViewController.sentAchievementIcon = achievementPictures[activeRow]
            }
                        
            //sends over goals for current level
            goalInfoViewController.currentTempLevel.removeAll()
            goalInfoViewController.currentTempLevel.append(goals)
            goalInfoViewController.currentTempLevel.append(rewards)
            goalInfoViewController.currentTempLevel.append(punishments)
            goalInfoViewController.currentTempLevel.append(achievements)
            goalInfoViewController.currentTempLevel.append(achievementPictures)
            goalInfoViewController.currentTempLevel.append(achieved)
            goalInfoViewController.currentTempLevel.append(goalNumber)
            
            //sends over tempLevels, current level, and  game Descritpions
            goalInfoViewController.tempGameText = gameText
            goalInfoViewController.tempGameDescription = gameDescription
            goalInfoViewController.tempLevel4 = level1
            goalInfoViewController.tempLevel5 = level2
            goalInfoViewController.tempLevel6 = level3
            goalInfoViewController.tempCurrentLevel = currentLevel
        }
        
        //to choose level send over values
        if segue.identifier == "toPlayLevel" {
            
            //send back all the values
            let playLevelViewController = segue.destination as! PlayLevelViewController
            
            playLevelViewController.currentLevel = 0
            playLevelViewController.gameName = self.gameText
            playLevelViewController.gameDescription = self.gameDescription
            playLevelViewController.level1 = self.level1
            playLevelViewController.level2 = self.level2
            playLevelViewController.level3 = self.level3
            
        }
        
    }
    
    func sortArray(array1: Array<Int>, array2: Array<Any?> ) -> Array<Any?> {
        
        let combined = zip(array1, array2).sorted {$0.0 < $1.0}
        
        _ = combined.map {$0.0}
        let sorted2 = combined.map {$0.1}
        
        return sorted2
        
    }
    
    
    
}
