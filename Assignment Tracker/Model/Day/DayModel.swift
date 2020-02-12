//
//  DayModel.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/12/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import Foundation

struct DayModel {
    var id: String!
    var course = ""
    var subtitle = ""
    var assignmentModels = [AssignmentModel]()
    
    init(course: String, subtitle: String, data: [AssignmentModel]?) {
        id = UUID().uuidString
        self.course = course
        self.subtitle = subtitle
        
        if let data = data {
            self.assignmentModels = data
        }
        
    }
}
