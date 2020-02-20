//
//  AddAssignmentViewController.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/17/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class AddAssignmentViewController: UITableViewController {
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var dayPickerView: UIPickerView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var assignmentTypeButtons: [UIButton]!
    
    
    var finishedSaving: ((Int, AssignmentModel) -> ())?
    var courseIndex: Int!
    var courseModel: CourseModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseLabel.font = UIFont(name: Theme.mainFontName, size: 24)
        
        dayPickerView.dataSource = self
        dayPickerView.delegate = self
    }
    
    @IBAction func AssignmentTypeSelected(_ sender: UIButton) {
        
        assignmentTypeButtons.forEach({ $0.tintColor = Theme.Accent })
        
        sender.tintColor = Theme.tintColor
    }
    
    
    @IBAction func save(_ sender: UIButton) {
        
        guard titleTextField.hasValue, let newTitle = titleTextField.text else { return }
        let assignmentType: AssignmentType = getSelectedAssignmentType()
        
        let dayIndex = dayPickerView.selectedRow(inComponent: 0)
        let assignmentModel = AssignmentModel(course: newTitle, subTitle: subtitleTextField.text ?? "", assignmentType: assignmentType)
        
        AssignmentFunctions.createAssignment(at: courseIndex, for: dayIndex, using: assignmentModel)
        
        if let finishedSaving = finishedSaving {
            finishedSaving(dayIndex, assignmentModel)
        }
        
        dismiss(animated: true)
    }
    
    func getSelectedAssignmentType() -> AssignmentType {
        for (index, button) in assignmentTypeButtons.enumerated() {
            if button.tintColor == Theme.tintColor {
                return AssignmentType(rawValue: index) ?? .essay
            }
        }
        
        return .essay
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}

extension AddAssignmentViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courseModel.dayModels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return courseModel.dayModels[row].course.mediumDate()
    }
}
