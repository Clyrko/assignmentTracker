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
    @IBOutlet weak var courseImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardView.addShadows()
        cardView.addRoundedCorners()
        cardView.backgroundColor = Theme.Accent
        
        courseLabel.font = UIFont(name: Theme.mainFontName, size: 40)
        
        courseImageView.layer.cornerRadius = cardView.layer.cornerRadius
    }

    func setup(courseModel: CourseModel) {
        courseLabel.text = courseModel.course
        
        if let courseImage = courseModel.image {
            courseImageView.alpha = 0.3
            courseImageView.image = courseImage
            
            UIView.animate(withDuration: 1) {
                self.courseImageView.alpha = 1
            }
        }
        courseImageView.image = courseModel.image
    }
}
