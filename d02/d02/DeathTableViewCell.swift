//
//  DeathTableViewCell.swift
//  d02
//
//  Created by Ivan BOHONOSIUK on 03.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class DeathTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var death : (String, String, String)? {
        didSet {
            if let d = death {
                nameLabel?.text = d.0
                descLabel?.text = d.1
                dateLabel?.text = d.2
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
