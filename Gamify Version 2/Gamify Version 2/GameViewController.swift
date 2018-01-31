//
//  GameViewController.swift
//  Gamify Version 2
//
//  Created by Brett Goldfine on 7/31/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //variables for game
    var gameText = ""
    var gameDescription = ""
    var level1: [Any] = []
    var level2: [Any] = []
    var level3: [Any] = []
    var currentLevel = 0
    
    var goals: [String] = []
    var rewards: [String] = []
    var punishments: [String] = []
    var achievements: [String?] = []
    var achievementPictures: [UIImage?] = []
    
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var rewardTextField: UITextField!
    @IBOutlet weak var punishmentTextField: UITextField!
    @IBOutlet weak var achievementTextField: UITextField!
    var achievementIconImage: UIImage? = nil
    @IBOutlet weak var achievementImageView: UIImageView!
    
    var activeRow = 0
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.lightGray
        self.table.backgroundColor = UIColor.lightGray
        
        //reload table if current level is the same and the level has a count
        if level1.count == 5 && currentLevel == 1 {
            goals = level1[0] as! [String]
            rewards = level1[1] as! [String]
            punishments = level1[2] as! [String]
            achievements = level1[3] as! [String?]
            achievementPictures = level1[4] as! [UIImage?]
            table.reloadData()
        }
        else if level2.count == 5 && currentLevel == 2 {
            goals = level2[0] as! [String]
            rewards = level2[1] as! [String]
            punishments = level2[2] as! [String]
            achievements = level2[3] as! [String?]
            achievementPictures = level2[4] as! [UIImage?]
            table.reloadData()
        }
        else if level3.count == 5 && currentLevel == 3 {
            goals = level3[0] as! [String]
            rewards = level3[1] as! [String]
            punishments = level3[2] as! [String]
            achievements = level3[3] as! [String?]
            achievementPictures = level3[4] as! [UIImage?]
            table.reloadData()
        }
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
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "\(indexPath.row + 1). \(goals[indexPath.row])"
        
        self.table.backgroundColor = UIColor.lightGray
        
        cell.textLabel?.textColor = UIColor.white
        
        return cell
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
            goalInfoViewController.sentAchievementDescription = achievements[activeRow]!
            
            //adds icon if not nil
            if achievementPictures[activeRow] != nil
            {
                goalInfoViewController.sentAchievementIcon = achievementPictures[activeRow]
            }
            
            //sends over goals for current level
            goalInfoViewController.currentTempLevel.removeAll()
            goalInfoViewController.currentTempLevel.append(goals)
            goalInfoViewController.currentTempLevel.append(rewards)
            goalInfoViewController.currentTempLevel.append(punishments)
            goalInfoViewController.currentTempLevel.append(achievements)
            goalInfoViewController.currentTempLevel.append(achievementPictures)
            
            //sends over tempLevels, current level, and  game Descritpions
            goalInfoViewController.tempGameText = gameText
            goalInfoViewController.tempGameDescription = gameDescription
            goalInfoViewController.tempLevel1 = level1
            goalInfoViewController.tempLevel2 = level2
            goalInfoViewController.tempLevel3 = level3
            goalInfoViewController.tempCurrentLevel = currentLevel
        }
        
        //to choose level send over values
        if segue.identifier == "toChooseLevel" {
            
            let chooseLevelViewController = segue.destination as! ChooseLevelViewController
            
            chooseLevelViewController.gameText = self.gameText
            chooseLevelViewController.gameDescription = self.gameDescription
            chooseLevelViewController.level1 = self.level1
            chooseLevelViewController.level2 = self.level2
            chooseLevelViewController.level3 = self.level3

            
        }
        
    }
    
    //delete a goal if user chooses
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            goals.remove(at: indexPath.row)
            rewards.remove(at: indexPath.row)
            punishments.remove(at: indexPath.row)
            achievements.remove(at: indexPath.row)
            achievementPictures.remove(at: indexPath.row)
        }
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }

    
    //helps add achievement icon by allowing user to access their photo library
    @IBAction func addAchievementIcon(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //after it is complete
        }
    }
    
    //called at end of addAchievementIcon(_ sener: Any) and 
    //changes image view and adds it to achievement pictures array
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            achievementImageView.image = image
            achievementIconImage = image
            
        } else {
            //error
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func submitGoal(_ sender: Any) {
        
        goals.append(goalTextField.text!)
        rewards.append(rewardTextField.text!)
        punishments.append(punishmentTextField.text!)
        achievements.append(achievementTextField.text!)
        
        //append nil if achievement or icon is empty, otherwise attach achievement and icon
        //may want to change so user can not select icon later
        if achievementIconImage == nil{
            achievementPictures.append(nil)
        } else {
            achievementPictures.append(achievementIconImage)
        }
        
        resetInputFields()
        table.reloadData()
    }
    
    //make sure level is clear then append all goals then clear goalArrays
    @IBAction func submitLevel(_ sender: Any) {
        if currentLevel == 1 {
            level1.removeAll()
            level1.append(goals)
            level1.append(rewards)
            level1.append(punishments)
            level1.append(achievements)
            level1.append(achievementPictures)
            resetInputFields()
            clearGoalArrays()
            performSegue(withIdentifier: "toChooseLevel", sender: self)
        }
        else if currentLevel == 2 {
            level2.removeAll()
            level2.append(goals)
            level2.append(rewards)
            level2.append(punishments)
            level2.append(achievements)
            level2.append(achievementPictures)
            resetInputFields()
            clearGoalArrays()
            performSegue(withIdentifier: "toChooseLevel", sender: self)
        }
        else if currentLevel == 3 {
            level3.removeAll()
            level3.append(goals)
            level3.append(rewards)
            level3.append(punishments)
            level3.append(achievements)
            level3.append(achievementPictures)
            resetInputFields()
            clearGoalArrays()
            performSegue(withIdentifier: "toChooseLevel", sender: self)
        }
    }
    
    
    
    
    //clears goal arrays to help clean up code
    func clearGoalArrays() {
        goals.removeAll()
        rewards.removeAll()
        punishments.removeAll()
        achievements.removeAll()
        achievementPictures.removeAll()
    }
    
    func resetInputFields() {
        
        //reset textFields and icon image
        goalTextField.text = ""
        rewardTextField.text = ""
        punishmentTextField.text = ""
        achievementTextField.text = ""
        achievementIconImage = nil
        achievementImageView.image = nil
    }
    
    //to shut down textfield if user touches elsewhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //to shut down text field if user hits return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
