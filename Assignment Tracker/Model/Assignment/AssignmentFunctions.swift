//
//  AssignmentFunctions.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/19/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import Foundation

class AssignmentFunctions {
    static func createAssignment(at courseIndex: Int, for dayIndex: Int, using assignmentModel: AssignmentModel) {
        // Replace with real data store code
        
        CourseData.courseModels[courseIndex].dayModels[dayIndex].assignmentModels.append(assignmentModel)
    }
}
