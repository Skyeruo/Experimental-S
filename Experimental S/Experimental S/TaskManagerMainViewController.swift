//
//  TaskManagerMainViewController.swift
//  Experimental S
//
//  Created by Fábio Carvalho on 23/08/16.
//  Copyright © 2016 Fábio Carvalho. All rights reserved.
//

import UIKit

class TaskManagerMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tasksTableView: UITableView!
    
    var taskData: NSArray!
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true);
        
        //Initializations
        self.title = "My tasks";
        defineTableViewCell("TaskCell", reuseIdentifier: "taskCell", tableView: self.tasksTableView)
        taskData = loadDataFromFile("TaskSource.plist")
        self.tasksTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //Table view row selection
        self.tasksTableView.indexPathsForSelectedRows?.forEach {
            self.tasksTableView.deselectRowAtIndexPath($0, animated: true)
        }
        
        self.tasksTableView .reloadData()
    }
    
    //MARK: Table View methods
    func defineTableViewCell(name: String, reuseIdentifier: String, tableView: UITableView){
        let nib = UINib(nibName: name, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return taskData! .count
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! TaskCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        //prolong separator line to whole screen
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        //cell content
        if indexPath.section == 0 {
            let currentTask = taskData![indexPath.row] as! NSDictionary
            
            cell.addTaskView.hidden = true
            cell.taskDetailsView.hidden = false
            
            //task progress indicator
            let currentTaskProgress = currentTask .objectForKey("progress") as! CGFloat
            cell.progressViewWidthConstraint.constant = currentTaskProgress * cell.frame.size.width / 100
            
            //cell fields
            cell.titleLabel.text = (currentTask .objectForKey("title") as! String)
            if((currentTask .objectForKey("subtitle")) as? String != ""){
                cell.subtitleLabel.text = (currentTask .objectForKey("subtitle") as! String)
            }else{
                cell.titleAlignCenterConstraint.priority = 999
                cell.subtitleLabel.hidden = true
            }
        }else{
            cell.addTaskView.hidden = false
            cell.taskDetailsView.hidden = true
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            self.selectedIndex = indexPath.row
        }else{
            self.selectedIndex = -1
        }
        performSegueWithIdentifier("mainToDetails", sender: self)
    }
    
    //MARK: Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue .identifier == "mainToDetails" {
            let nextVC = segue .destinationViewController as! TaskDetailsViewController
            nextVC.taskData = self.taskData
            nextVC.selectedIndex = self.selectedIndex
            if self.selectedIndex == -1 {
                nextVC.isEditing = true;
                nextVC.title = "New task"
            }else{
                nextVC.isEditing = false;
            }
        }
    }
    
    //MARK: Read/Write methods
    func loadDataFromFile(fileName:String) -> NSArray {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent(fileName)
        let data = NSArray(contentsOfFile: path)
        return data!
    }
    
}
