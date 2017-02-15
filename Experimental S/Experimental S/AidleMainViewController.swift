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
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var changeStanceButton: UIButton!
    @IBOutlet weak var encounterView: UIView!
    
    let notificationCenter = NotificationCenter.default
    
    var progressBarAnimator: UIViewPropertyAnimator!
    var canEncounter: Bool = true
    var shouldProgress: Bool = true
    var stepCount: NSInteger = 0{
        didSet{
            self .stepCountDidChange()
        }
    }
    
    
    //MARK: Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self .setupUI()
        
        notificationCenter.addObserver(self, selector: #selector(appWillResignActive), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appDidBecomeActive), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self .setProgressBarAnimator()
        self .startProgress()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self .notificationCenter .removeObserver(self)
    }
    
    
    //MARK: Progress bar methods
    func setProgressBarAnimator() {
        self .progressBarAnimator = UIViewPropertyAnimator(duration: 5.0, curve: .linear){
            self .progressBar .setProgress(1.0, animated: false)
            self .view .layoutIfNeeded()
        }
        
        self .progressBarAnimator .addCompletion { (end) in
            self .stepCount += 1
            
            //Repeat animation
            self .progressBar .setProgress(0.0, animated: false)
            self .view .layoutIfNeeded()
            self .setProgressBarAnimator()
            self .startProgress()
        }
    }
    
    func startProgress() {
        if shouldProgress {
            self .progressBarAnimator .startAnimation()
        }
    }
    
    func stopProgress() {
        self .progressBarAnimator .pauseAnimation()
        self .shouldProgress = false
    }
    
    @IBAction func startProgressAction(_ sender: UIButton) {
        self .startProgress()
    }

    @IBAction func stopProgressAction(_ sender: UIButton) {
        self .stopProgress()
    }
    
    
    //MARK: Button actions
    @IBAction func changeStanceButtonAction(_ sender: UIButton) {
        self .canEncounter = !self .canEncounter
        if self .canEncounter {
            self .changeStanceButton .setTitle("Lower your head", for: UIControlState .normal)
        }else{
            self .changeStanceButton .setTitle("Raise your head", for: UIControlState .normal)
        }
    }
    
    
    //MARK: Utility methods
    func setupUI(){
        self .title = "Aidle"
        self .navigationController? .navigationBar .barTintColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:1.0)
        self .navigationController? .navigationBar .titleTextAttributes = [NSForegroundColorAttributeName: UIColor .white]
        UIApplication .shared .statusBarStyle = UIStatusBarStyle .lightContent
        self .view .backgroundColor = UIColor .black
        
        self .changeStanceButton .layer .borderWidth = 1
        self .changeStanceButton .layer .borderColor = UIColor .lightGray .cgColor
        
        self .encounterView .isHidden = true
    }
    
    func appWillResignActive(){
        self .stopProgress()
    }
    
    func appDidBecomeActive(){
        self .startProgress()
    }
    
    func stepCountDidChange(){
        self .stepCountLabel .text = "Steps taken: \(self .stepCount)"
        
        if !canEncounter{
            return
        }
        
        let encounterCheck = Int(arc4random_uniform(10)) == 0 ? true : false
        if encounterCheck {
            print("ENCOUNTER GET")
            self .stopProgress()
            self .encounterView .isHidden = false
        }
    }
}
