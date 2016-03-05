//
//  EventTableViewCell.swift
//  RexEvents
//
//  Created by Paul O'Neill on 1/30/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    

    @IBOutlet weak var ePic: UIImageView!
    @IBOutlet weak var eTime: UILabel!
    @IBOutlet weak var eDay: UILabel!
    @IBOutlet weak var eDate: UILabel!
    @IBOutlet weak var eTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = UIColor.clearColor()
        // Configure the view for the selected state
    }

}
