//
//  ChooseCategoryTableViewCell.swift
//  Bucket List Lab Version 3
//
//  Created by Brett Goldfine on 8/13/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class ChooseCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var downloadGameButton: UIButton!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
