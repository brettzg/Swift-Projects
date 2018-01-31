//
//  GoalInfoViewController.swift
//  Gamify Version 2
//
//  Created by Brett Goldfine on 7/31/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import CoreData

class GoalInfoViewController: UIViewController {
    
    //variables for both
    var currentTempLevel: [Any] = []
    var tempGameText = ""
    var tempGameDescription = ""
    var tempCurrentLevel = 0

    //variables for making game
    var tempLevel1: [Any] = []
    var tempLevel2: [Any] = []
    var tempLevel3: [Any] = []
    
    //variables for playing game
    var tempLevel4: [NSManagedObject] = []
    var tempLevel5: [NSManagedObject] = []
    var tempLevel6: [NSManagedObject] = []

    
    //internal variables to show data
    var sentGoalDescription = ""
    var sentRewardDescription = ""
    var sentPunishmentDescription = ""
    var sentAchievementDescription: String? = nil
    var sentAchievementIcon: UIImage? = nil
    
    
    @IBOutlet weak var goalDescription: UILabel!
    @IBOutlet weak var rewardDescription: UILabel!
    @IBOutlet weak var punishmentDescription: UILabel!
    @IBOutlet weak var achievementDescription: UILabel!
    @IBOutlet weak var achievementIconImageView: UIImageView!
    
    //go back and reset goal descriptions

    @IBAction func goBack(_ sender: Any) {
        
        sentGoalDescription = ""
        sentRewardDescription = ""
        sentPunishmentDescription = ""
        sentAchievementDescription = nil
        sentAchievementIcon = nil
        
        //reset description and image
        achievementDescription.text = nil
        achievementIconImageView.image = nil
        
        if currentTempLevel.count == 5 {
            performSegue(withIdentifier: "toGoalDesign", sender: self)
        }
        if currentTempLevel.count == 7 {
            performSegue(withIdentifier: "toPlayGame", sender: self)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.lightGray
        
        //set up texts and image if possible for description
        goalDescription.text = sentGoalDescription
        rewardDescription.text = sentRewardDescription
        punishmentDescription.text = sentPunishmentDescription
        
        //if sent achievement and icon arent nil, set them to nil
        if sentAchievementDescription != nil && sentAchievementIcon != nil {
            achievementDescription.text = sentAchievementDescription
            achievementIconImageView.image = sentAchievementIcon
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //to goal design send over values
        if segue.identifier == "toGoalDesign" {
            
            let gameViewController = segue.destination as! GameViewController
            
            //sends back goals
            gameViewController.goals = currentTempLevel[0] as! [String]
            gameViewController.rewards = currentTempLevel[1] as! [String]
            gameViewController.punishments = currentTempLevel[2] as! [String]
            gameViewController.achievements = currentTempLevel[3] as! [String?]
            gameViewController.achievementPictures = currentTempLevel[4] as! [UIImage?]
            
            //send back macro
            gameViewController.gameText = tempGameText
            gameViewController.gameDescription = tempGameDescription
            gameViewController.level1 = tempLevel1
            gameViewController.level2 = tempLevel2
            gameViewController.level3 = tempLevel3
            gameViewController.currentLevel = tempCurrentLevel
        }
        
        if segue.identifier == "toPlayGame" {
            
            let playGameViewController = segue.destination as! PlaySpecificLevelViewController
            
            //send back goals
            /*playGameViewController.goals = currentTempLevel[0] as! [String]
            playGameViewController.rewards = currentTempLevel[1] as! [String]
            playGameViewController.punishments = currentTempLevel[2] as! [String]
            playGameViewController.achievements = currentTempLevel[3] as! [String?]
            playGameViewController.achievementPictures = currentTempLevel[4] as! [UIImage?]
            playGameViewController.achieved = currentTempLevel[5] as! [Bool]
            playGameViewController.goalNumber = currentTempLevel[6] as! [Int]
            */
            
            //send back variables
            playGameViewController.gameText = tempGameText
            playGameViewController.gameDescription = tempGameDescription
            playGameViewController.level1 = tempLevel4
            playGameViewController.level2 = tempLevel5
            playGameViewController.level3 = tempLevel6
            playGameViewController.currentLevel = tempCurrentLevel
            
        }
        
    }

}
