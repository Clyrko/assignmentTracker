//
//  CoursesTableViewCell.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/6/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class CoursesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var courseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardView.addShadows()
        cardView.addRoundedCorners()
        
        courseLabel.font = UIFont(name: Theme.mainFontName, size: 40)
    }

    func setup(courseModel: CourseModel) {
        courseLabel.text = courseModel.course
    }
}
