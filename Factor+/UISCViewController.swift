//
//  UISCViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-04.
//  Copyright © 2015 LYM. All rights reserved.
//
//  The View Controller class for User Input Sine and Cosine Law.
//  Currently not in use.
//

import UIKit

class UISCViewController: UIViewController {
    
    var ttlScore = Int(), numQuestions = Int()

    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var progressUISC: UIProgressView!
    
    @IBAction func pauseClicked(sender: AnyObject) {
    
        performSegueWithIdentifier("pauseUISC", sender: sender)
    }

    @IBAction func changeProgress(sender: AnyObject) {
       
        numQuestions++
        var temp = Double(numQuestions)/10
        progressUISC.setProgress(Float(temp), animated: true)
        endGame()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var temp = Double(numQuestions)/10
        progressUISC.setProgress(Float(temp), animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func endGame() {
        
        if(numQuestions == 10)
        {
            performSegueWithIdentifier("endUISC", sender: self)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "pauseUISC") {
            
            let pvc = segue.destinationViewController as! PauseViewController
            pvc.numQuestion = numQuestions
            pvc.score = ttlScore
            pvc.type = "User Input Sine Cosine"
        }
        else if(segue.identifier == "endUISC") {
            
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "User Input Sine Cosine"
        }
    }

}
