//
//  AddDayViewController.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/15/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class AddDayViewController: UIViewController {

    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    var finishedSaving: (() -> ())?
    var courseIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseLabel.font = UIFont(name: Theme.mainFontName, size: 40)
        
        courseLabel.layer.shadowOpacity = 1
        courseLabel.layer.shadowColor = UIColor.white.cgColor
        courseLabel.layer.shadowOffset = CGSize.zero
        courseLabel.layer.shadowRadius = 5
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func save(_ sender: Any) {
        
        titleTextField.rightViewMode = .never
        
        guard titleTextField.text != "", let newCourseName = titleTextField.text else {
            
            titleTextField.layer.borderColor = UIColor.red.cgColor
            titleTextField.layer.borderWidth = 2
            titleTextField.layer.cornerRadius = 5
            
            titleTextField.placeholder = "Required!"
            
            titleTextField.rightViewMode = .unlessEditing
            
            return
        }
        
//        if let index = courseIndexToEdit {
//            CourseFunctions.updateCourse(at: index, course: newCourseName, image: imageView.image)
//        } else {
//            CourseFunctions.createCourse(courseModel: CourseModel(course: newCourseName, image: imageView.image))
//        }
        
        if let finishedSaving = finishedSaving {
            finishedSaving()
        }
        dismiss(animated: true)
    }
    
}
