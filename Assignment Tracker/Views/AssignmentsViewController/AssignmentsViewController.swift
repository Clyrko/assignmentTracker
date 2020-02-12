//
//  AssignmentsViewController.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/12/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class AssignmentsViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var courseId: UUID!
    var courseModel: CourseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        CourseFunctions.readCourse(by: courseId) { [weak self] (model) in
            guard let self = self else { return }
            self.courseModel = model
            
            guard let model = model else { return }
            self.title = model.course
            self.backgroundImageView.image = model.image
            self.tableView.reloadData()
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension AssignmentsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return courseModel?.dayModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let course = courseModel?.dayModels[section].course ?? ""
        let subtitle = courseModel?.dayModels[section].subtitle ?? ""
        return "\(course) - \(subtitle)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseModel?.dayModels[section].assignmentModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell ")
        }
        
        cell?.textLabel?.text = courseModel?.dayModels[indexPath.section].assignmentModels[indexPath.row].course
        
        return cell!
    }
    
}
