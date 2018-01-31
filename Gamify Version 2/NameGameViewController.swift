//
//  NameGameViewController.swift
//  Gamify Version 2
//
//  Created by Brett Goldfine on 8/1/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class NameGameViewController: UIViewController, UITextFieldDelegate {
    
    var gameText = ""
    var gameDescription = ""
    
    @IBOutlet weak var nameGameTextField: UITextField!
    @IBOutlet weak var gameDescriptionTextField: UITextField!
    
    //submit gamename
    @IBAction func submitGameName(_ sender: Any) {
        if nameGameTextField.text! != "" {
            gameText = nameGameTextField.text!
            gameDescription = gameDescriptionTextField.text!
            performSegue(withIdentifier: "toChooseLevel", sender: self)
        } else {
            //display error
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toChooseLevel" {
            
            let chooseLevelViewController = segue.destination as! ChooseLevelViewController
            
            chooseLevelViewController.gameText = self.gameText
            chooseLevelViewController.gameDescription = self.gameDescription
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
