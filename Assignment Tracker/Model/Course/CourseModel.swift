//
//  CourseModel.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/6/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class CourseModel {
    let id: UUID
    var course: String
    var image: UIImage?
    
    init(course: String, image: UIImage? = nil) {
        id = UUID()
        self.course = course
        self.image = image
    }
}
