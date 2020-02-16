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
    var dayModels = [DayModel]() {
        didSet {
            // Called when a new value is assigned to dayModels
//            dayModels = dayModels.sorted(by: { (dayModel1, dayModel2) -> Bool in
//                dayModel1.course < dayModel2.course
//            })
//
//            dayModels = dayModels.sorted(by: { $0.course < $1.course })
            
            dayModels = dayModels.sorted(by: <)
        }
    }
    
    init(course: String, image: UIImage? = nil, dayModels: [DayModel]? = nil) {
        id = UUID()
        self.course = course
        self.image = image
        
        if let dayModels = dayModels{
            self.dayModels = dayModels
        }
    }
}
