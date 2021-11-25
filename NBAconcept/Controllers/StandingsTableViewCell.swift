//
//  StandingsTableViewCell.swift
//  NBAconcept
//
//  Created by Arturs Ziemelis on 25/11/2021.
//

import UIKit

class StandingsTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamShortnameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
