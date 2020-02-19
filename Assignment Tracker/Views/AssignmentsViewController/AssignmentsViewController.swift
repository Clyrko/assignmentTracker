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
    @IBOutlet weak var addButton: AppUIButton!
    
    var courseId: UUID!
    var courseCourse = ""
    var courseModel: CourseModel?
    var sectionHeaderHeight: CGFloat = 0.0
    
    fileprivate func updateTableViewWithCourseData() {
        CourseFunctions.readCourse(by: courseId) { [weak self] (model) in
            guard let self = self else { return }
            self.courseModel = model
            
            guard let model = model else { return }
            self.backgroundImageView.image = model.image
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = courseCourse
        addButton.createFloatingButtonAction()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        updateTableViewWithCourseData()
        
        sectionHeaderHeight = tableView.dequeueReusableCell(withIdentifier: "headerCell")?.contentView.bounds.height ?? 0
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addAction(_ sender: AppUIButton) {
        let alert = UIAlertController(title: "Which one will you like to add?", message: nil, preferredStyle: .actionSheet)
        let dayAction =  UIAlertAction(title: "Day", style: .default, handler: handleAddDay)
        let assignmentAction = UIAlertAction(title: "Assignment", style: .default, handler: handleAddAssignment)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        assignmentAction.isEnabled = courseModel!.dayModels.count > 0
        
        alert.addAction(dayAction)
        alert.addAction(assignmentAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = sender
        alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: -4, width: sender.bounds.width, height: sender.bounds.height)
        
        alert.view.tintColor = Theme.tintColor
        
        present(alert, animated: true)
    }
    
    fileprivate func getCourseIndex() -> Int? {
        return CourseData.courseModels.firstIndex(where: { (courseModel) -> Bool in
            courseModel.id == courseId
        })
    }
    
    func handleAddAssignment(action: UIAlertAction) {
        let vc = AddAssignmentViewController.getInstance() as! AddAssignmentViewController
        vc.courseModel = courseModel
        vc.courseIndex = getCourseIndex()
        vc.finishedSaving = { [weak self] dayIndex, assignmentModel in
            guard let self = self else { return }
            
            self.courseModel?.dayModels[dayIndex].assignmentModels.append(assignmentModel)
            
            let row = (self.courseModel?.dayModels[dayIndex].assignmentModels.count)! - 1
            let indexPath = IndexPath(row: row, section: dayIndex)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        present(vc, animated: true)
    }
    
    func handleAddDay(action: UIAlertAction) {
        let vc = AddDayViewController.getInstance() as! AddDayViewController
        vc.courseModel = courseModel
        vc.courseIndex = getCourseIndex()
        
        vc.finishedSaving = { [weak self] dayModel in
            guard let self = self else { return }
            
            self.courseModel?.dayModels.append(dayModel)
            
            let indexArray = [self.courseModel?.dayModels.firstIndex(of: dayModel) ?? 0 ]
            
            self.tableView.insertSections(IndexSet(indexArray), with: UITableView.RowAnimation.automatic)
        }
        present(vc, animated: true)
    }
}

extension AssignmentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return courseModel?.dayModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let dayModel = courseModel?.dayModels[section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderTableViewCell
        cell.setup(model: dayModel!)
        
        return cell.contentView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseModel?.dayModels[section].assignmentModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = courseModel?.dayModels[indexPath.section].assignmentModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AssignmentTableViewCell
        
        cell.setup(model: model!)
        
        return cell
    }
    
}
