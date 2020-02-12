//
//  CourseModel.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/6/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

struct CourseModel {
    let id: UUID
    var course: String
    var image: UIImage?
    var dayModels = [DayModel]()
    
    init(course: String, image: UIImage? = nil, dayModels: [DayModel]? = nil) {
        id = UUID()
        self.course = course
        self.image = image
        
        if let dayModels = dayModels{
            self.dayModels = dayModels
        }
    }
}
