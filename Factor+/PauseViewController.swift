//
//  PauseViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-02.
//  Copyright © 2015 LYM. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController {
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    var numQuestion = Int()
    var score = Int()
    var type = String()
    
    @IBAction func restartGame(sender: AnyObject) {
        score = 0
        numQuestion = 0
        continueToGame()
    }
    @IBAction func continueGame(sender: AnyObject) {
        
        continueToGame()
    }
    @IBAction func goToMenu(sender: AnyObject) {
        score = 0
        numQuestion = 0
        type = ""
        performSegueWithIdentifier("MainMenu", sender: sender)
    }
    
    func continueToGame (){
        if(type == "Multiple Choice Factor")
        {
            performSegueWithIdentifier("Continue MCF", sender: self)
        }
        else if(type == "User Input Factor")
        {
            performSegueWithIdentifier("Continue UIF", sender: self)
        }
        else if(type == "Multiple Choice Graph")
        {
            performSegueWithIdentifier("Continue MCG", sender: self)
        }
        else if(type == "User Input Graph")
        {
            performSegueWithIdentifier("Continue UIG", sender: self)
        }
        else if(type == "Multiple Choice Trig")
        {
            performSegueWithIdentifier("Continue MCT", sender: self)
        }
        else if(type == "User Input Right Triangle")
        {
            performSegueWithIdentifier("Continue UIR", sender: self)
        }
        else if(type == "User Input Sine Cosine")
        {
            performSegueWithIdentifier("Continue UISC", sender: self)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "MainMenu")
        {
            let mvc = segue.destinationViewController as! MainViewController
        }
        else if(segue.identifier == "Continue MCF")
        {
            let mcvc = segue.destinationViewController as! MultipleChoiceViewController
            mcvc.ttlScore = score
            mcvc.numQuestions = numQuestion
        }
        else if(segue.identifier == "Continue UIF")
        {
            let uifvc = segue.destinationViewController as! UIFViewController
            uifvc.numQuestions = numQuestion
            uifvc.ttlScore = score
        }
        else if(segue.identifier == "Continue MCG")
        {
            let mc2vc = segue.destinationViewController as! MultipleChoice2ViewController
            mc2vc.numQuestions = numQuestion
            mc2vc.ttlScore = score
        }
        else if(segue.identifier == "Continue UIG")
        {
            let uigvc = segue.destinationViewController as! UIGViewController
            uigvc.numQuestions = numQuestion
            uigvc.ttlScore = score
        }
        else if(segue.identifier == "Continue MCT")
        {
            let mctvc = segue.destinationViewController as! MCTViewController
            mctvc.numQuestions = numQuestion
            mctvc.ttlScore = score
        }
        else if(segue.identifier == "Continue UIR")
        {
            let uirvc = segue.destinationViewController as! UIRViewController
            uirvc.ttlScore = score
            uirvc.numQuestions = numQuestion
        }
        else if(segue.identifier == "Continue UISC")
        {
            let uiscvc = segue.destinationViewController as! UISCViewController
            uiscvc.numQuestions = numQuestion
            uiscvc.ttlScore = score
        }
    }
}
