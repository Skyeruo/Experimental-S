//
//  EntryPointViewController.swift
//  Experimental S
//
//  Created by Fábio Carvalho on 23/08/16.
//  Copyright © 2016 Fábio Carvalho. All rights reserved.
//

import UIKit

class EntryPointViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func summonXPSTaskManager(_ sender: UIButton) {
        NSLog("Starting Task Manager")
        performSegue(withIdentifier: "entryToTaskManager", sender: self)
    }
    
}
