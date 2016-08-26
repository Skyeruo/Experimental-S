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

    var task: TaskDataObject?
    var isEditing: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //Initializations
        self.title = task?.title
        self .setTextFieldStyle()
        if self.isEditing == true {
            self.topRightButton.image = UIImage(named:"ic_confirmButton")
            self .setFieldsEnabled(true)
        }else{
            self.topRightButton.image = UIImage(named:"ic_editButton")
            self .setFieldsEnabled(false)
        }
    }
    
    @IBAction func topRightButtonPressed(sender: UIBarButtonItem) {
        if self.isEditing == false {
            self.topRightButton.image = UIImage(named:"ic_confirmButton")
            self.isEditing = true
            self .setFieldsEnabled(true)
        }else{
            self.topRightButton.image = UIImage(named:"ic_editButton")
            self.isEditing = false
            self .setFieldsEnabled(false)
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

}
