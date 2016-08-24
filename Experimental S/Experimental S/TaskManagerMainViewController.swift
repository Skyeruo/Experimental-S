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
    
    var taskData: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true);
        
        //MARK: Initializations
        self.title = "Tasks";
        self.navigationController?.navigationBar.barTintColor = UIColor(red:CGFloat(92/255), green:CGFloat(172/255), blue:CGFloat(238/255), alpha:CGFloat(1))
        
        let nib = UINib(nibName: "TaskCell", bundle: nil)
        self.tasksTableView.registerNib(nib, forCellReuseIdentifier: "taskCell")
        
        let path = NSBundle.mainBundle().pathForResource("TaskSource", ofType: "plist")
        taskData = NSMutableArray(contentsOfFile: path!)
    }
    
    //MARK: Table View methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return taskData .count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! TaskCell
        
        let currentTask = taskData![indexPath.row] as! NSDictionary
        cell.titleLabel.text = (currentTask .objectForKey("title") as! String)
        if((currentTask .objectForKey("subtitle")) as! String != ""){
            cell.subtitleLabel.text = (currentTask .objectForKey("subtitle") as! String)
        }else{
            cell.titleAlignCenterConstraint.priority = 999
            cell.subtitleLabel.hidden = true
        }
        
        return cell
    }
    
}
