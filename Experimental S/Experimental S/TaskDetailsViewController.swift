//
//  TaskDetailsViewController.swift
//  Experimental S
//
//  Created by Fábio Carvalho on 23/08/16.
//  Copyright © 2016 Fábio Carvalho. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {

    var task: TaskDataObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //Initializations
        self.title = task?.title;
    }
    
}
