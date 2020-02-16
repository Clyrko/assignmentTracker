//
//  MockData.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/12/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import Foundation

class MockData {
    static func createMockCourseModelData() -> [CourseModel] {
        var mockCourses = [CourseModel]()
        mockCourses.append(CourseModel(course: "Orientation", dayModels: createmockDayModelData()))
        mockCourses.append(CourseModel(course: "University 101"))
        mockCourses.append(CourseModel(course: "CUL 403: Coding"))
        return mockCourses
    }
    
    static func createmockDayModelData() -> [DayModel] {
        var dayModels = [DayModel]()
        
        dayModels.append(DayModel(course: "April 18", subtitle: "Assignments", data: createMockAssignmentModelData(sectionTitle: "April 18")))
        dayModels.append(DayModel(course: "April 19", subtitle: "Due", data: createMockAssignmentModelData(sectionTitle: "April 19")))
        dayModels.append(DayModel(course: "April 20", subtitle: "Scuba Diving!", data: createMockAssignmentModelData(sectionTitle: "April 20")))
        dayModels.append(DayModel(course: "April 21", subtitle: "Volunteering", data: createMockAssignmentModelData(sectionTitle: "April 21")))
        dayModels.append(DayModel(course: "April 22", subtitle: "Time to go back home", data: createMockAssignmentModelData(sectionTitle: "April 22")))
        
        return dayModels
    }
    
    static func createMockAssignmentModelData(sectionTitle: String) -> [AssignmentModel] {
        var models = [AssignmentModel]()
        
        switch sectionTitle {
        case "April 18":
            models.append(AssignmentModel(course: "Intro to CU", subTitle: "Group Presentation", assignmentType: AssignmentType.group))
            models.append(AssignmentModel(course: "Programming 403", subTitle: "Group Presentation", assignmentType: AssignmentType.group))
        case "April 19":
            models.append(AssignmentModel(course: "Intro to CU", subTitle: "", assignmentType: AssignmentType.group))
            models.append(AssignmentModel(course: "Bintang Kuta Hotel Checkin", subTitle: "Confirmation: AX76Y2", assignmentType: AssignmentType.test))
            models.append(AssignmentModel(course: "Pick up rental", subTitle: "Confirmation: 996464", assignmentType: AssignmentType.essay))
            models.append(AssignmentModel(course: "Island Excusion", subTitle: "Touring the island", assignmentType: AssignmentType.presentation))
            models.append(AssignmentModel(course: "Dinner", subTitle: "at Warung Sanur Segar", assignmentType: AssignmentType.quiz))
        case "April 20":
            models.append(AssignmentModel(course: "Scuba Diving", subTitle: "Checking out the Reefs!", assignmentType: AssignmentType.presentation))
            models.append(AssignmentModel(course: "Dinner", subTitle: "at Malaika Secret Moksha", assignmentType: AssignmentType.quiz))
        case "April 21":
            models.append(AssignmentModel(course: "Travel", subTitle: "to Nusa Penida", assignmentType: AssignmentType.group))
            models.append(AssignmentModel(course: "Volunteering", subTitle: "at Tanglad Village", assignmentType: AssignmentType.presentation))
            models.append(AssignmentModel(course: "Dinner", subTitle: "at Warung Made", assignmentType: AssignmentType.quiz))
            models.append(AssignmentModel(course: "Travel", subTitle: "back to Denpasar", assignmentType: AssignmentType.group))
        case "April 22":
            models.append(AssignmentModel(course: "Hotel Checkout", subTitle: "from Bintang Kuta Hotel", assignmentType: AssignmentType.test))
            models.append(AssignmentModel(course: "DPS", subTitle: "Denpasar", assignmentType: AssignmentType.group))
            models.append(AssignmentModel(course: "LAX", subTitle: "Los Angeles", assignmentType: AssignmentType.group))
            models.append(AssignmentModel(course: "SLC", subTitle: "Salt Lake City", assignmentType: AssignmentType.group))
        default:
            models.append(AssignmentModel(course: "", subTitle: "", assignmentType: AssignmentType.presentation))
        }
        
        return models
    }
}
