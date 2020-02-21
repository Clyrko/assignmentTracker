//
//  AssignmentModel.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/12/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import Foundation

import UIKit

struct AssignmentModel {
    var id: String!
    var course = ""
    var subTitle = ""
    var assignmentType: AssignmentType
    var photo: UIImage?
    
    init(course: String, subTitle: String, assignmentType: AssignmentType, photo: UIImage? = nil) {
        id = UUID().uuidString
        self.course = course
        self.subTitle = subTitle
        self.assignmentType = assignmentType
        self.photo = photo
        
    }
}

extension AssignmentModel: Equatable {
    static func == (lhs: AssignmentModel, rhs: AssignmentModel) -> Bool {
        return lhs.id == rhs.id
    }
}
