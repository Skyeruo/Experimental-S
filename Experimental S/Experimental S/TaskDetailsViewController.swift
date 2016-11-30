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
    var isUserEditing: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Initializations
        if self.selectedIndex != -1 {
            self .mapTaskFromData()
            self.title = task.title
        }
        
        self.titleErrorLabel.text = "A title is required."
        self .setTextFieldStyle()
        
        if self.isUserEditing == true {
            self.topRightButton.image = UIImage(named:"ic_confirmButton")
            self .setFieldsEnabled(true)
        }else{
            self.topRightButton.image = UIImage(named:"ic_editButton")
            self .setFieldsEnabled(false)
            self .populateFields(self.task)
        }
    }
    
    @IBAction func topRightButtonPressed(_ sender: UIBarButtonItem) {
        if self.isUserEditing == false {
            self.topRightButton.image = UIImage(named:"ic_confirmButton")
            self.isUserEditing = true
            self .setFieldsEnabled(true)
        }else{
            if self.titleTextField.text != "" {
                self .saveDataToFile("TaskSource")
                self.topRightButton.image = UIImage(named:"ic_editButton")
                self.isUserEditing = false
                self .setFieldsEnabled(false)
            }else{
                self.titleErrorLabel.isHidden = false
            }
        }
        
    }
    
    //MARK: Utility methods
    func setTextFieldStyle() {
        let borderColor = UIColor(red:204.0/255.0, green:204.0/255.0, blue:204.0/255.0, alpha:1.0)
        self.detailsTextView.layer.borderColor = borderColor.cgColor
        self.detailsTextView.layer.borderWidth = 1.0
        self.detailsTextView.layer.cornerRadius = 5.0
        self.titleTextField.layer.borderColor = borderColor.cgColor
        self.titleTextField.layer.borderWidth = 1.0
        self.titleTextField.layer.cornerRadius = 5.0
        self.subtitleTextField.layer.borderColor = borderColor.cgColor
        self.subtitleTextField.layer.borderWidth = 1.0
        self.subtitleTextField.layer.cornerRadius = 5.0
    }
    
    func setFieldsEnabled(_ option: Bool){
        switch option {
        case true:
            self.titleTextField.isEnabled = true
            self.subtitleTextField.isEnabled = true
            self.detailsTextView.isEditable = true
            self.progressSlider.isEnabled = true
            break;
        default:
            self.titleTextField.isEnabled = false
            self.subtitleTextField.isEnabled = false
            self.detailsTextView.isEditable = false
            self.progressSlider.isEnabled = false
            break;
        }
    }
    
    func populateFields(_ task: TaskDataObject){
        self.titleTextField.text = task.title
        self.subtitleTextField.text = task.subtitle
        self.detailsTextView.text = task.details
        self.progressSlider .setValue(Float(task.progress), animated: true)
    }
    
    func mapTaskFromData(){
        let selectedTaskData = self.taskData .object(at: self.selectedIndex!) as! NSDictionary
        self.task.title = selectedTaskData .value(forKey: "title") as! String
        self.task.subtitle = selectedTaskData .value(forKey: "subtitle") as! String
        self.task.details = selectedTaskData .value(forKey: "details") as! String
        self.task.progress = selectedTaskData .value(forKey: "progress") as! Int
    }
    
    func saveDataToFile(_ name: String) {
        if let path:String = Bundle.main.path(forResource: name, ofType: "plist"){
            
            let editedTask: NSMutableDictionary = ["title": self.titleTextField.text!]
            editedTask .setObject(self.subtitleTextField.text!, forKey: "subtitle" as NSCopying)
            editedTask .setObject(self.detailsTextView.text!, forKey: "details" as NSCopying)
            editedTask .setObject(Int(self.progressSlider.value), forKey: "progress" as NSCopying)
            
            let newTaskData = self.taskData .mutableCopy() as! NSMutableArray
            if self.selectedIndex != -1 {
                newTaskData .replaceObject(at: self.selectedIndex!, with: editedTask)
            }else{
                newTaskData .add(editedTask)
            }
            
            _ = newTaskData .write(toFile: path, atomically: false)
            
        }
    }
}
