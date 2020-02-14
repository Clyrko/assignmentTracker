//
//  HeaderTableViewCell.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/13/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        courseLabel.font = UIFont(name: Theme.bodyFontNameExtraBold, size: 17)
        subtitleLabel.font = UIFont(name: Theme.bodyFontName, size: 15)
    }

    func setup(model: DayModel) {
        courseLabel.text = model.course
        subtitleLabel.text = model.subtitle
    }
}
