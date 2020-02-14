//
//  AssignmentTableViewCell.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/14/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var assignmentImageView: UIImageView!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.addShadows()
        cardView.addRoundedCorners()
        courseLabel.font = UIFont(name: Theme.bodyFontNameBold, size: 17)
        subtitleLabel.font = UIFont(name: Theme.bodyFontName, size: 17)
    }
    
    func setup(model: AssignmentModel) {
        assignmentImageView.image = getAssignmentImage(type: model.assignmentType)
        courseLabel.text = model.course
        subtitleLabel.text = model.subTitle
    }
    
    func getAssignmentImage(type: AssignmentType) -> UIImage?
    {
        switch type {
        case .essay:
            return #imageLiteral(resourceName: "paperIcon")
        case .presentation:
            return #imageLiteral(resourceName: "presentationIcon")
        case .group:
            return #imageLiteral(resourceName: "groupIcon")
        case .quiz:
            return #imageLiteral(resourceName: "quizIcon")
        case .test:
            return #imageLiteral(resourceName: "testIcon")
        }
    }
}
