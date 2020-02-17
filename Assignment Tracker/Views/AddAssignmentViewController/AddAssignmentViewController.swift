//
//  AddAssignmentViewController.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/17/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class AddAssignmentViewController: UIViewController {
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var dayPickerView: UIPickerView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    var courseIndex: Int!
    var courseModel: CourseModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseLabel.font = UIFont(name: Theme.mainFontName, size: 24)
    }
    
    @IBAction func save(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
