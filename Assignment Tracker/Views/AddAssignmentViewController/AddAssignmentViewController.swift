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
    
    // Editing Assignments
    var dayIndexToEdit: Int?
    var assignmentModelToEdit: AssignmentModel!
    var finishedUpdating: ((Int, Int, AssignmentModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseLabel.font = UIFont(name: Theme.mainFontName, size: 24)
        
        dayPickerView.dataSource = self
        dayPickerView.delegate = self
        
        if let dayIndex = dayIndexToEdit, let assignmentModel = assignmentModelToEdit {
            // Update Assignment: Populate the popup
            courseLabel.text = "Edit Assignment"
            
            // Select the Day in the Picker View
            dayPickerView.selectRow(dayIndex, inComponent: 0, animated: true)
            
            // Populate the Assignment Data
            AssignmentTypeSelected(assignmentTypeButtons[assignmentModel.assignmentType.rawValue])
            titleTextField.text = assignmentModel.course
            subtitleTextField.text = assignmentModel.subTitle
        } else {
            // New Assignment: Set default values
            AssignmentTypeSelected(assignmentTypeButtons[AssignmentType.essay.rawValue])
        }
    }
    
    @IBAction func AssignmentTypeSelected(_ sender: UIButton) {
        
        assignmentTypeButtons.forEach({ $0.tintColor = Theme.Accent })
        sender.tintColor = Theme.tintColor
    }
    
    
    @IBAction func save(_ sender: UIButton) {
        
        guard titleTextField.hasValue, let newTitle = titleTextField.text else { return }
        let assignmentType: AssignmentType = getSelectedAssignmentType()
        
        let newDayIndex = dayPickerView.selectedRow(inComponent: 0)
        
        if assignmentModelToEdit != nil {
            // Update Assignment
            
            assignmentModelToEdit.assignmentType = assignmentType
            assignmentModelToEdit.course = newTitle
            assignmentModelToEdit.subTitle = subtitleTextField.text ?? ""
            
            AssignmentFunctions.updateAssignment(at: courseIndex, oldDayIndex: dayIndexToEdit!, newDayIndex: newDayIndex, using: assignmentModelToEdit)
            
            if let finishedUpdating = finishedUpdating, let oldDayIndex = dayIndexToEdit {
                finishedUpdating(oldDayIndex, newDayIndex, assignmentModelToEdit)
            }
        } else {
            // New Assignment
            let assignmentModel = AssignmentModel(course: newTitle, subTitle: subtitleTextField.text ?? "", assignmentType: assignmentType)
            AssignmentFunctions.createAssignment(at: courseIndex, for: newDayIndex, using: assignmentModel)
            
            if let finishedSaving = finishedSaving {
                finishedSaving(newDayIndex, assignmentModel)
            }
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
