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
import QuartzCore

class AidleMainViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var progressBarAnimator: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Initializations
        self .title = "Aidle"
        self .navigationController? .navigationBar .barTintColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:1.0)
        self .navigationController? .navigationBar .titleTextAttributes = [NSForegroundColorAttributeName: UIColor .white]
        UIApplication .shared .statusBarStyle = UIStatusBarStyle .lightContent
        self .view .backgroundColor = UIColor .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self .setProgressBarAnimator()
        self .progressBarAnimator .startAnimation()
    }
    
    
    //MARK: Progress bar methods
    func setProgressBarAnimator(){
        self .progressBarAnimator = UIViewPropertyAnimator(duration: 5.0, curve: .linear){
            self .progressBar .setProgress(1.0, animated: false)
            self .view .layoutIfNeeded()
        }
        
        self .progressBarAnimator .addCompletion { (end) in
            self .progressBar .setProgress(0.0, animated: false)
            self .view .layoutIfNeeded()
            self .setProgressBarAnimator()
            self .progressBarAnimator .startAnimation()
        }
    }
    
    @IBAction func stopProgress(_ sender: UIButton) {
        self .progressBarAnimator .pauseAnimation()
    }
    
    @IBAction func startProgress(_ sender: Any) {
        self .progressBarAnimator .startAnimation()
    }
    
}
