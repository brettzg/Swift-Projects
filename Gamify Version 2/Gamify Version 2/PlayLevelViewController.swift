//
//  PlayLevelViewController.swift
//  Gamify Version 2
//
//  Created by Brett Goldfine on 8/2/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import CoreData

class PlayLevelViewController: UIViewController {

    //these are set up in my games view controller
    var gameName = ""
    var gameDescription = ""
    var level1: [NSManagedObject] = []
    var level2: [NSManagedObject] = []
    var level3: [NSManagedObject] = []
    var currentLevel = 0
    
    //used to store when coming back from viewing level
    
    @IBOutlet weak var gameNameLabel: UILabel!
    
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlayGame" {
            
            let playSpecificViewController = segue.destination as! PlaySpecificLevelViewController
            
            //send over all necessary values
            playSpecificViewController.gameText = self.gameName
            playSpecificViewController.gameDescription = self.gameDescription
            playSpecificViewController.level1 = self.level1
            playSpecificViewController.level2 = self.level2
            playSpecificViewController.level3 = self.level3
            playSpecificViewController.currentLevel = self.currentLevel
        }
    }
    
    @IBAction func playLevel1(_ sender: Any) {
        
        currentLevel = 1
        performSegue(withIdentifier: "toPlayGame", sender: self)
    }
    
    
    @IBAction func playLevel2(_ sender: Any) {
        
        currentLevel = 2
        performSegue(withIdentifier: "toPlayGame", sender: self)
    }
    
    @IBAction func playLevel3(_ sender: Any) {
        
        currentLevel = 3
        performSegue(withIdentifier: "toPlayGame", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        
        gameNameLabel.text = gameName
        gameDescriptionLabel.text = gameDescription
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
