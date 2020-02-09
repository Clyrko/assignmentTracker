//
//  AddCourseViewController.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/7/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit
import Photos

class AddCourseViewController: UIViewController {
    
    
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIButton!
    
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
    
    
    @IBAction func addPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    let myPickerController = UIImagePickerController()
                    myPickerController.delegate = self
                    myPickerController.sourceType = .photoLibrary
                    self.present(myPickerController, animated: true)
                default:
                    break
//                case .notDetermined:
//                    <#code#>
//                case .restricted:
//                    <#code#>
//                case .denied:
//                    <#code#>
                }
            }
        }
    }
}

extension AddCourseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
