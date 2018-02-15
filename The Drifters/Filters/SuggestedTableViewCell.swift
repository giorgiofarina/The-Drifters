//
//  SuggestedTableViewCell.swift
//  The Drifters
//
//  Created by Graziella Caputo on 14/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class SuggestedTableViewCell: UITableViewCell {

    @IBOutlet weak var suggestedView: UIView!
    @IBOutlet weak var suggestedPlantImageView: UIImageView!
    @IBOutlet weak var suggestedPlantNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
