//
//  AddCourseViewController.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/7/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class AddCourseViewController: UIViewController {
    
    
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var finishedSaving: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseLabel.font = UIFont(name: Theme.mainFontName, size: 40)
    
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func save(_ sender: Any) {
        
        courseTextField.rightViewMode = .never
        
        guard courseTextField.text != "", let newCourseName = courseTextField.text else {
            
            courseTextField.layer.borderColor = UIColor.red.cgColor
            courseTextField.layer.borderWidth = 2
            courseTextField.layer.cornerRadius = 5
            
            courseTextField.placeholder = "Required!"
            
            courseTextField.rightViewMode = .unlessEditing
            
            return
        }
        
        CourseFunctions.createCourse(courseModel: CourseModel(course: newCourseName))
        
        if let finishedSaving = finishedSaving {
            finishedSaving()
        }
        dismiss(animated: true)
    }
}
