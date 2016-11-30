//
//  DuelGameMainViewController.swift
//  Experimental S
//
//  Created by Fábio Carvalho on 30/11/2016.
//  Copyright © 2016 Fábio Carvalho. All rights reserved.
//

import UIKit

class DuelGameMainViewController: UIViewController {

    @IBOutlet weak var meleeButton: UIButton!
    @IBOutlet weak var rangedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Initializations
        self .title = "Duel Game"
        self .navigationController? .navigationBar .barTintColor = UIColor .orange
    }
    
    @IBAction func meleeButtonPressed(_ sender: UIButton) {
        UIView .animate(withDuration: 0.5, animations: {
            self.rangedButton.alpha = 0
        })
        
        UIView .animate(withDuration: 1.5, animations: {
            self.meleeButton.alpha = 0
        }, completion: { _ in
            //start game
        })
    }
    
    @IBAction func rangedButtonPressed(_ sender: UIButton) {
        UIView .animate(withDuration: 0.5, animations: {
            self.meleeButton.alpha = 0
        })
        
        UIView .animate(withDuration: 1.5, animations: {
            self.rangedButton.alpha = 0
        }, completion: { _ in
            //start game
        })
    }
    
}