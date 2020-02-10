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
        
        courseLabel.layer.shadowOpacity = 1
        courseLabel.layer.shadowColor = UIColor.white.cgColor
        courseLabel.layer.shadowOffset = CGSize.zero
        courseLabel.layer.shadowRadius = 5
        
        imageView.layer.cornerRadius = 10
    
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
        // , image: imageView.image
        
        if let finishedSaving = finishedSaving {
            finishedSaving()
        }
        dismiss(animated: true)
    }
    
    
    fileprivate func presentPhotoPickerController() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true)
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    self.presentPhotoPickerController()
                    
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized {
                        self.presentPhotoPickerController()
                    }
                    
                case .restricted:
                    let alert = UIAlertController(title: "Photo Library Restriced", message: "Photo Library is restriced and cannot be assesed", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                    
                case .denied:
                    let alert = UIAlertController(title: "Photo Library Access Denied", message: "Photo Library was previously denied. Please update your settings if you wish to change this.", preferredStyle: .alert)
                    let gotoSettingsAction = UIAlertAction(title: "Go to Settings", style: .default) { (action) in
                        DispatchQueue.main.async {
                            let url = URL(string: UIApplication.openSettingsURLString)!
                            UIApplication.shared.open(url, options: [ : ])
                        }
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    alert.addAction(gotoSettingsAction)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true)
                }
        }
    }
}

extension AddCourseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
//            self.imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
