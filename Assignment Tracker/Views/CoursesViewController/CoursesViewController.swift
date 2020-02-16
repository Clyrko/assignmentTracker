//
//  CoursesViewController.swift
//  Assignment Tracker
//
//  Created by Jay A. on 2/6/20.
//  Copyright © 2020 Jay A. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var helpView: UIVisualEffectView!
    
    var courseIndexToEdit: Int?
    let seenCourseHelp = "seenCourseHelp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        CourseFunctions.readCourse(completion: { [unowned self] in
            self.tableView.reloadData()

            if CourseData.courseModels.count > 0 {
                if UserDefaults.standard.bool(forKey: self.seenCourseHelp)  == false {
                    self.view.addSubview(self.helpView)
                    self.helpView.frame = self.view.bounds
                }
            }
        })
        
        
        view.addSubview(helpView)
        helpView.frame = view.frame
        view.backgroundColor = Theme.backgroundColor
        addButton.createFloatingButtonAction()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddCourseSegue" {
            let popup = segue.destination as! AddCourseViewController
            popup.courseIndexToEdit = self.courseIndexToEdit
            popup.finishedSaving = { [weak self] in
                self?.tableView.reloadData()
            }
            courseIndexToEdit = nil
        }
    }
    

    @IBAction func closeHelpView(_ sender: AppUIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.helpView.alpha = 0
        }) { (success) in
            self.helpView.removeFromSuperview()
            UserDefaults.standard.set(true, forKey: self.seenCourseHelp)
        }
    }
}


extension CoursesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CourseData.courseModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CoursesTableViewCell
        
        cell.setup(courseModel:CourseData.courseModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let course = CourseData.courseModels[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
            
            let alert = UIAlertController(title: "Delete Course", message: "Are you sure you want to delete this course: \(course.course)?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                CourseFunctions.deleteCourse(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerformed(true)
            }))
            
            self.present(alert, animated: true)
        }
        
        delete.image = #imageLiteral(resourceName: "deleteButton")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            self.courseIndexToEdit = indexPath.row
            self.performSegue(withIdentifier: "toAddCourseSegue", sender: nil)
            actionPerformed(true)
        }
        
        edit.image = #imageLiteral(resourceName: "editIcon")
        edit.backgroundColor = Theme.secondaryTintColor 
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = CourseData.courseModels[indexPath.row]
        
        let vc = AssignmentsViewController.getInstance() as! AssignmentsViewController
        
        vc.courseId = course.id
        vc.courseCourse = course.course
         navigationController?.pushViewController(vc, animated: true)
    }
}
