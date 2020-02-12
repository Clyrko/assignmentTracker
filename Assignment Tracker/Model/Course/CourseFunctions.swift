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
                CourseData.courseModels = MockData.createMockCourseModelData()
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
        
    }
    
    static func readCourse(by id: UUID, completion: @escaping (CourseModel?) -> ())  {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let course = CourseData.courseModels.first(where: { $0.id == id})
        
            DispatchQueue.main.async {
                completion(course)
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
