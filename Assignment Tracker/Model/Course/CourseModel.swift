//
//  CourseModel.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/6/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import Foundation

class CourseModel {
    var id: String!
    var course: String!
    
    init(course: String) {
        id = UUID().uuidString
        self.course = course
    }
}
