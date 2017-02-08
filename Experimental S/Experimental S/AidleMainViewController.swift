//
//  AidleMainViewController.swift
//  Experimental S
//
//  Created by Fábio Carvalho on 08/02/2017.
//  Copyright © 2017 Fábio Carvalho. All rights reserved.
//

/*
 Attempt at a mildly interesting idle ("Aidle") game type of thing. Eh.
 */

import UIKit

class AidleMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Initializations
        self .title = "Aidle"
        self .navigationController? .navigationBar .barTintColor = UIColor .white
        self .navigationController? .navigationBar .barStyle = .blackOpaque
    }


}
