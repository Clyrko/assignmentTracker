//
//  CourseFunctions.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/6/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import Foundation

class CourseFunctions {
    static func createCourse(courseModel: CourseModel) {
        
    }
    
    static func readCourse(completion: @escaping () -> ())  {
        DispatchQueue.global(qos: .userInteractive).async {
            if CourseData.courseModels.count == 0 {
                CourseData.courseModels.append(CourseModel(course: "Intro to XCODE"))
                CourseData.courseModels.append(CourseModel(course: "Swift 101"))
                CourseData.courseModels.append(CourseModel(course: "Need to Upgrade"))
            }
            DispatchQueue.main.async {
                completion()
            }
        }
        
    }
    
    static func updateCourse(courseModel: CourseModel) {
        
    }
    
    static func deleteCourse(courseModel: CourseModel) {
        
    }
}
