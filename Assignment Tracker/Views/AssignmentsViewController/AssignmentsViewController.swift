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
    
    fileprivate func getCourseIndex() -> Int! {
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
    
    
    @IBAction func toggleEditMode(_ sender: UIBarButtonItem) {
        tableView.isEditing.toggle()
        sender.title = sender.title == "Edit" ? "Done" : "Edit"
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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit") {
            (contextualAction, view, actionPerformed: (Bool) -> ()) in
            let vc = AddAssignmentViewController.getInstance() as! AddAssignmentViewController
            vc.courseModel = self.courseModel
            
            // Which Course are we working with
            vc.courseIndex = self.getCourseIndex()
            
            // Which Day are we on
            vc.dayIndexToEdit = indexPath.section
            
            // Which Assignment are we editing?
            vc.assignmentModelToEdit = self.courseModel?.dayModels[indexPath.section].assignmentModels[indexPath.row]
            
            //What do we want to happen after the Assignment is saved
            vc.finishedUpdating = { [ weak self] oldDayIndex, newDayIndex, assignmentModel in
                guard let self = self else { return }
                
                let oldAssignmentIndex = (self.courseModel?.dayModels[oldDayIndex].assignmentModels.firstIndex(of: assignmentModel))!
                
                if oldDayIndex == newDayIndex {
                    // 1. Update the local table data
                    self.courseModel?.dayModels[newDayIndex].assignmentModels[oldAssignmentIndex] = assignmentModel
                    
                    // 2. Refresh just that row
                    let indexPath = IndexPath(row: oldAssignmentIndex, section: newDayIndex)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                } else {
                    // Assignment moved to a different day
                    
                    // 1. Remove assignment from local table data
                    self.courseModel?.dayModels[oldDayIndex].assignmentModels.remove(at: oldAssignmentIndex)
                    // 2. Insert assignment into new location
                    let lastIndex = (self.courseModel?.dayModels[newDayIndex].assignmentModels.count)!
                    self.courseModel?.dayModels[newDayIndex].assignmentModels.insert(assignmentModel, at: lastIndex)
                    // 3. Update rows
                    tableView.performBatchUpdates({
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        let insertIndexPath = IndexPath(row: lastIndex, section: newDayIndex)
                        tableView.insertRows(at: [insertIndexPath], with: .automatic)
                    })
                }
            }
            
            self.present(vc, animated: true)
            actionPerformed(true)
        }
        
        edit.image = #imageLiteral(resourceName: "editIcon")
        edit.backgroundColor = Theme.secondaryTintColor
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let assignmentModel = courseModel!.dayModels[indexPath.section].assignmentModels[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
            
            let alert = UIAlertController(title: "Delete Assignment", message: "Are you sure you want to delete this assignment: \(assignmentModel.course)?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                AssignmentFunctions.deleteAssignment(at: self.getCourseIndex(), for: indexPath.section, using: assignmentModel)
                
                self.courseModel!.dayModels[indexPath.section].assignmentModels.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerformed(true)
            }))
            
            self.present(alert, animated: true)
        }
        
        delete.image = #imageLiteral(resourceName: "deleteButton")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let assignmentModel = (courseModel?.dayModels[sourceIndexPath.section].assignmentModels[sourceIndexPath.row])!
        
        courseModel?.dayModels[sourceIndexPath.section].assignmentModels.remove(at: sourceIndexPath.row)
        
        courseModel?.dayModels[destinationIndexPath.section].assignmentModels.insert(assignmentModel, at: destinationIndexPath.row)
        
        AssignmentFunctions.reorderAssignment(at: getCourseIndex(), oldDayIndex: sourceIndexPath.section, newDayIndex: destinationIndexPath.section, newAssignmentIndex: destinationIndexPath.row, assignmentModel: assignmentModel)
    }
}
