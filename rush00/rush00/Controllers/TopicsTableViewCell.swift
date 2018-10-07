//
//  TopicsTableViewCell.swift
//  rush00
//
//  Created by Ivan BOHONOSIUK on 07.10.2018.
//  Copyright © 2018 Ivan BOHONOSIUK. All rights reserved.
//

import UIKit

class TopicsTableViewCell: UITableViewCell {
    
    var topic: Topics?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
