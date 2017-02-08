//
//  TaskManagerMainViewController.swift
//  Experimental S
//
//  Created by Fábio Carvalho on 23/08/16.
//  Copyright © 2016 Fábio Carvalho. All rights reserved.
//

/*
 Simple task management app. Nothing much to see here, used mainly to experiment with persistent data storage and Core Data.
 */

import UIKit
import CoreData

@available(iOS 10.0, *)
class TaskManagerMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tasksTableView: UITableView!
    
    var taskData: NSArray!
    var selectedIndex: Int!
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Database initialization
//        container = NSPersistentContainer(name: "Experimental S")
//        container.loadPersistentStores { storeDescription, error in
//            if let error = error {
//                print("Unresolved error \(error)")
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Initializations
        self.title = "My tasks"
        defineTableViewCell("TaskCell", reuseIdentifier: "taskCell", tableView: self.tasksTableView)
        self.taskData = loadDataFromFile("TaskSource")
        self.tasksTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //Table view row selection
        self.tasksTableView.indexPathsForSelectedRows?.forEach {
            self.tasksTableView.deselectRow(at: $0, animated: true)
        }
        
        self.tasksTableView .reloadData()
    }
    
    //MARK: Table View methods
    func defineTableViewCell(_ name: String, reuseIdentifier: String, tableView: UITableView){
        let nib = UINib(nibName: name, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.taskData! .count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskCell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        //prolong separator line to whole screen
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        //cell content
        if indexPath.section == 0 {
            let currentTask = self.taskData![indexPath.row] as! NSDictionary
            
            cell.addTaskView.isHidden = true
            cell.taskDetailsView.isHidden = false
            
            //task progress indicator
            let currentTaskProgress = currentTask .object(forKey: "progress") as! CGFloat
            cell.progressViewWidthConstraint.constant = currentTaskProgress * cell.frame.size.width / 100
            
            //cell fields
            cell.titleLabel.text = (currentTask .object(forKey: "title") as! String)
            if((currentTask .object(forKey: "subtitle")) as? String != ""){
                cell.subtitleLabel.text = (currentTask .object(forKey: "subtitle") as! String)
            }else{
                cell.titleAlignCenterConstraint.priority = 999
                cell.subtitleLabel.isHidden = true
            }
        }else{
            cell.addTaskView.isHidden = false
            cell.taskDetailsView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.selectedIndex = indexPath.row
        }else{
            self.selectedIndex = -1
        }
        performSegue(withIdentifier: "mainToDetails", sender: self)
    }
    
    //MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue .identifier == "mainToDetails" {
            let nextVC = segue .destination as! TaskDetailsViewController
            nextVC.taskData = self.taskData
            nextVC.selectedIndex = self.selectedIndex
            if self.selectedIndex == -1 {
                nextVC.isUserEditing = true
                nextVC.title = "New task"
            }else{
                nextVC.isUserEditing = false
            }
        }
    }
    
    //MARK: Read/Write methods
    func loadDataFromFile(_ fileName:String) -> NSArray? {
        if let path:String = Bundle.main.path(forResource: fileName, ofType: "plist"){
            let data = NSArray(contentsOfFile: path)
            return data
        }else{
            return nil
        }
    }
    
}
