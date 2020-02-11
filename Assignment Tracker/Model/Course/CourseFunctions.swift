//
//  CourseFunctions.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/6/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class CourseFunctions {
    static func createCourse(courseModel: CourseModel) {
        CourseData.courseModels.append(courseModel)
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
    
    static func updateCourse(at index: Int, course: String, image: UIImage? = nil) {
        CourseData.courseModels[index].course = course
        CourseData.courseModels[index].image = image
    }
    
    static func deleteCourse(index: Int) {
        CourseData.courseModels.remove(at: index)
    }
}
