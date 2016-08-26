//
//  TaskDetailsViewController.swift
//  Experimental S
//
//  Created by Fábio Carvalho on 23/08/16.
//  Copyright © 2016 Fábio Carvalho. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {

    @IBOutlet weak var topRightButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleErrorLabel: UILabel!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var progressSlider: UISlider!

    var task = TaskDataObject()
    var taskData: NSArray!
    var selectedIndex: Int?
    var isEditing: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //Initializations
        if self.selectedIndex != -1 {
            self .mapTaskFromData()
            self.title = task.title
        }
        
        self.titleErrorLabel.text = "A title is required."
        self .setTextFieldStyle()
        
        if self.isEditing == true {
            self.topRightButton.image = UIImage(named:"ic_confirmButton")
            self .setFieldsEnabled(true)
        }else{
            self.topRightButton.image = UIImage(named:"ic_editButton")
            self .setFieldsEnabled(false)
            self .populateFields(self.task)
        }
    }
    
    @IBAction func topRightButtonPressed(sender: UIBarButtonItem) {
        if self.isEditing == false {
            self.topRightButton.image = UIImage(named:"ic_confirmButton")
            self.isEditing = true
            self .setFieldsEnabled(true)
        }else{
            if self.titleTextField.text != "" {
                self .saveDataToFile("TaskSource.plist")
                self.topRightButton.image = UIImage(named:"ic_editButton")
                self.isEditing = false
                self .setFieldsEnabled(false)
            }else{
                self.titleErrorLabel.hidden = false
            }
        }
        
    }
    
    //MARK: Utility methods
    func setTextFieldStyle() {
        let borderColor = UIColor(red:204.0/255.0, green:204.0/255.0, blue:204.0/255.0, alpha:1.0)
        self.detailsTextView.layer.borderColor = borderColor.CGColor
        self.detailsTextView.layer.borderWidth = 1.0
        self.detailsTextView.layer.cornerRadius = 5.0
        self.titleTextField.layer.borderColor = borderColor.CGColor
        self.titleTextField.layer.borderWidth = 1.0
        self.titleTextField.layer.cornerRadius = 5.0
        self.subtitleTextField.layer.borderColor = borderColor.CGColor
        self.subtitleTextField.layer.borderWidth = 1.0
        self.subtitleTextField.layer.cornerRadius = 5.0
    }
    
    func setFieldsEnabled(option: Bool){
        switch option {
        case true:
            self.titleTextField.enabled = true
            self.subtitleTextField.enabled = true
            self.detailsTextView.editable = true
            self.progressSlider.enabled = true
            break;
        default:
            self.titleTextField.enabled = false
            self.subtitleTextField.enabled = false
            self.detailsTextView.editable = false
            self.progressSlider.enabled = false
            break;
        }
    }
    
    func populateFields(task: TaskDataObject){
        self.titleTextField.text = task.title
        self.subtitleTextField.text = task.subtitle
        self.detailsTextView.text = task.details
        self.progressSlider.setValue(Float(task.progress), animated: true)
    }
    
    func mapTaskFromData(){
        let selectedTaskData = self.taskData .objectAtIndex(self.selectedIndex!) as! NSDictionary
        self.task.title = selectedTaskData .valueForKey("title") as! String
        self.task.subtitle = selectedTaskData .valueForKey("subtitle") as! String
        self.task.details = selectedTaskData .valueForKey("details") as! String
        self.task.progress = selectedTaskData .valueForKey("progress") as! Int
    }
    
    func saveDataToFile(name: String) {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent(name)
        
        let editedTask: NSMutableDictionary = ["title": self.titleTextField.text!]
        editedTask.setObject(self.subtitleTextField.text!, forKey: "subtitle")
        editedTask.setObject(self.detailsTextView.text!, forKey: "details")
        editedTask.setObject(Int(self.progressSlider.value), forKey: "progress")
        
        let newTaskData = self.taskData .mutableCopy()
        if self.selectedIndex != -1 {
            newTaskData .replaceObjectAtIndex(self.selectedIndex!, withObject: editedTask)
        }else{
            newTaskData .addObject(editedTask)
        }
        
        newTaskData .writeToFile(path, atomically: false)
    }
}
