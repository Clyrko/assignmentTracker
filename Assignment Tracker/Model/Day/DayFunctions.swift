//
//  DayFunctions.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/16/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import Foundation

class DayFunctions {
    static func createDay(at courseIndex: Int, using dayModel: DayModel) {
        // Replace with real data store code
        
        CourseData.courseModels[courseIndex].dayModels.append(dayModel)
    }
}
