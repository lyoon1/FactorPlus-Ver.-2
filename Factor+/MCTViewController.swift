//
//  MCTViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-04.
//  Copyright © 2015 LYM. All rights reserved.
//
//  The View Controller class for Multiple Choice Trigonometry.
//  Currently not in use.
//

import UIKit

class MCTViewController: UIViewController {
    
    var ttlScore = Int(), numQuestions = Int()
    
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    @IBOutlet weak var choice3Button: UIButton!
    @IBOutlet weak var choice4Button: UIButton!
    @IBOutlet weak var progressMCT: UIProgressView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var coverUpButton: UIButton!
    
    @IBAction func choice1Clicked(sender: AnyObject) {
    
        changeProgress()
    }
    
    @IBAction func choice2Clicked(sender: AnyObject) {
        
        changeProgress()
    }
    
    @IBAction func choice3Clicked(sender: AnyObject) {
        
        changeProgress()
    }
    
    @IBAction func choice4Clicked(sender: AnyObject) {
    
        changeProgress()
    }
    
    @IBAction func pauseClicked(sender: AnyObject) {
        
        performSegueWithIdentifier("pauseMCT", sender: sender)
    }
    
    func changeProgress() {
        
        numQuestions++
        var temp = Double(numQuestions)/10
        progressMCT.setProgress(Float(temp), animated: true)
        endGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var temp = Double(numQuestions)/10
        progressMCT.setProgress(Float(temp), animated: false)
        coverUpButton.hidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func endGame() {
        if(numQuestions == 10)
        {
            performSegueWithIdentifier("endMCT", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "pauseMCT") {
            
            let pvc = segue.destinationViewController as! PauseViewController
            pvc.score = ttlScore
            pvc.numQuestion = numQuestions
            pvc.type = "Multiple Choice Trig"
        }
        else if(segue.identifier == "endMCT") {
            
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "Multiple Choice Trig"
        }
    }

}
