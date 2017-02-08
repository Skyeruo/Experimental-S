//
//  JourneyStartViewController.swift
//  Experimental S
//
//  Created by Fábio Carvalho on 05/12/2016.
//  Copyright © 2016 Fábio Carvalho. All rights reserved.
//

/*
Created to test more complex animations between screens and UI element states.
 */

import UIKit

class JourneyStartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Initializations
        self .title = "Who am I?"
        self .navigationController? .navigationBar .barTintColor = UIColor(red: 0.4, green: 0.8, blue: 0.0, alpha: 1.0)
    }
    
    
    
}
