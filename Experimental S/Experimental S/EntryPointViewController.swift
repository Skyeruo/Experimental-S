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
    
    @IBAction func summonXPSDuelGame(_ sender: UIButton) {
        NSLog("Starting Duel Game")
        performSegue(withIdentifier: "entryToDuelGame", sender: self)
    }
    
    @IBAction func summonXPSJourney(_ sender: UIButton) {
        NSLog("Starting Journey")
        performSegue(withIdentifier: "entryToJourney", sender: self)
    }
    
    @IBAction func summonXPSAidle(_ sender: UIButton) {
        NSLog("Starting Aidle")
        performSegue(withIdentifier: "entryToAidle", sender: self)
    }
    
}
