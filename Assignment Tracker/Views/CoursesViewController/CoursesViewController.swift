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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        CourseFunctions.readCourse(completion: { [weak self] in
            self?.tableView.reloadData()
        })
        
        view.backgroundColor = Theme.backgroundColor
        addButton.createFloatingButtonAction()
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
}
