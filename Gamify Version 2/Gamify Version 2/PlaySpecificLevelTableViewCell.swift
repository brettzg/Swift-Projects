//
//  PlaySpecificLevelTableViewCell.swift
//  Gamify Version 2
//
//  Created by Brett Goldfine on 8/9/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class PlaySpecificLevelTableViewCell: UITableViewCell {

    @IBOutlet weak var goalNameLabel: UILabel!
    
    @IBOutlet weak var achievedButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
