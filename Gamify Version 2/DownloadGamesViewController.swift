//
//  DownloadGamesViewController.swift
//  Gamify Version 2
//
//  Created by Brett Goldfine on 8/10/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class DownloadGamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var gameNames: [String] = []
    var gameDescriptions: [String] = []
    var level1: [[Any]] = []
    var level2: [[Any]] = []
    var level3: [[Any]] = []
    
    var activeRow = 0
    
    //table count
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return gameNames.count
        
    }

    //create cell and show the names
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = gameNames[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.white
                
        return cell
    }
    
    //if user selects a table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activeRow = indexPath.row
        
        performSegue(withIdentifier: "toDirectDownload", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDirectDownload" {
            
            let directDownloadViewController = segue.destination as! DirectDownloadViewController
            
            directDownloadViewController.gameName = self.gameNames[activeRow]
            directDownloadViewController.gameDescription = self.gameDescriptions[activeRow]
            directDownloadViewController.level1 = self.level1[activeRow]
            directDownloadViewController.level2 = self.level2[activeRow]
            directDownloadViewController.level2 = self.level2[activeRow]
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadFirstGame()
        self.view.backgroundColor = UIColor.lightGray
        self.table.backgroundColor = UIColor.lightGray

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadFirstGame() {
        
        //first game name & description
        gameNames.append("First Download")
        gameDescriptions.append("Nice Download bro")
        
        //set up variables
        var goals: [String] = []
        var rewards: [String] = []
        var punishments: [String] = []
        var achievements: [String?] = []
        var achievementPictures: [UIImage?] = []
        
        //levels to add to level array
        var gameLevel1: [Any] = []
        var gameLevel2: [Any] = []
        var gameLevel3: [Any] = []
        
        //variables that will change based on level
        goals.append("First Try")
        rewards.append("")
        punishments.append("")
        achievements.append(nil)
        achievementPictures.append(nil)
        
        //add to game level 1
        gameLevel1.append(goals)
        gameLevel1.append(rewards)
        gameLevel1.append(punishments)
        gameLevel1.append(achievements)
        gameLevel1.append(achievementPictures)
        
        //now would reset variable arrays, append to them, then append to gameLevel2
        
        
        level1.append(gameLevel1)
        level2.append(gameLevel2)
        level3.append(gameLevel3)
        
        // Do any additional setup after loading the view.
        
    }
    

    
}
