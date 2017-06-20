//
//  CustomTableViewCell.swift
//  Mor3
//
//  Created by Ferran Rosales on 19/6/17.
//  Copyright © 2017 Ferran Rosales. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var edadLabel: UILabel!
    @IBOutlet weak var eresLabel: UILabel!
    @IBOutlet weak var distLabel: UILabel!
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
