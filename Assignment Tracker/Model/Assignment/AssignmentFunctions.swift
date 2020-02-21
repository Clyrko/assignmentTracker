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
    
    static func deleteAssignment(at courseIndex: Int, for dayIndex: Int, using assignmentModel: AssignmentModel) {
        // Replace with real data store code
        
        let dayModel = CourseData.courseModels[courseIndex].dayModels[dayIndex]
        
        if let index = dayModel.assignmentModels.firstIndex(of: assignmentModel) {
            CourseData.courseModels[courseIndex].dayModels[dayIndex].assignmentModels.remove(at: index)
        }
    }
}
