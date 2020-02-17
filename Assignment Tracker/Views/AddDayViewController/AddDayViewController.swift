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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    var finishedSaving: ((DayModel) -> ())?
    var courseIndex: Int!
    var courseModel: CourseModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseLabel.font = UIFont(name: Theme.mainFontName, size: 40)
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func save(_ sender: Any) {
        
        if alreadyExists(datePicker.date) {
            let alert = UIAlertController(title: "This Day Already Exists", message: "Please Select Another Day", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(okAction)
            present(alert, animated: true)
            return
        }
        
        let dayModel = DayModel(course: datePicker.date, subtitle: subtitleTextField.text ?? "", data: nil)
        DayFunctions.createDay(at: courseIndex, using: dayModel)

        if let finishedSaving = finishedSaving {
            finishedSaving(dayModel)
        }
        dismiss(animated: true)
    }
    
    func alreadyExists(_ date: Date) -> Bool {
//        if courseModel.dayModels.contains(where: { (dayModel) -> Bool in
//            return dayModel.course == date
//        }) {
//            return true
//        }
        
        if courseModel.dayModels.contains(where: { $0.course.mediumDate() == date.mediumDate() }) {
            
            return true
        }
        
        return false
    }
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
}
