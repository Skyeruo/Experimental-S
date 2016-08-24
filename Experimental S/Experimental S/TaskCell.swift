//
//  TaskCell.swift
//  Experimental S
//
//  Created by Fábio Carvalho on 24/08/16.
//  Copyright © 2016 Fábio Carvalho. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleAlignCenterConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
