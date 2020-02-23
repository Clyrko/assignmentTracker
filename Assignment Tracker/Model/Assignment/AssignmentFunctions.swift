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
    
    static func updateAssignment(at courseIndex: Int, oldDayIndex: Int, newDayIndex: Int, using assignmentModel: AssignmentModel) {
        // Replace with real data store code
        
        if oldDayIndex != newDayIndex {
            // Move assignment to a different Day
            
            let lastIndex  = CourseData.courseModels[courseIndex].dayModels[newDayIndex].assignmentModels.count
            reorderAssignment(at: courseIndex, oldDayIndex: oldDayIndex, newDayIndex: newDayIndex, newAssignmentIndex: lastIndex, assignmentModel: assignmentModel)
        } else {
            // Update assignment in the same Day
            
            let dayModel = CourseData.courseModels[courseIndex].dayModels[oldDayIndex]
            let assignmentIndex = (dayModel.assignmentModels.firstIndex(of: assignmentModel))!
            CourseData.courseModels[courseIndex].dayModels[newDayIndex].assignmentModels[assignmentIndex] = assignmentModel
        }
    }
    
    static func reorderAssignment(at courseIndex: Int, oldDayIndex: Int, newDayIndex: Int, newAssignmentIndex: Int, assignmentModel: AssignmentModel) {
        // Replace with real data store code
        
        //1. Remove assignment from old location
        let oldDayModel = CourseData.courseModels[courseIndex].dayModels[oldDayIndex]
        let oldAssignmentIndex = (oldDayModel.assignmentModels.firstIndex(of: assignmentModel))!
        CourseData.courseModels[courseIndex].dayModels[oldDayIndex].assignmentModels.remove(at: oldAssignmentIndex)
        
        //2. Insert assignment into new location
        CourseData.courseModels[courseIndex].dayModels[newDayIndex].assignmentModels.insert(assignmentModel, at: newAssignmentIndex)
    }
}
