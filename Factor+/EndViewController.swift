//
//  EndViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-05.
//  Copyright © 2015 LYM. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {
    
    var numCorrect = Int(), type = String(), score = Int(), numQuestion = Int()
    
    @IBOutlet weak var questionTypeLabel: UILabel!
    
    @IBOutlet weak var numCorrectLabel: UILabel!

    @IBOutlet weak var numWrongLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionTypeLabel.text = type
        numCorrectLabel.text = String(numCorrect)
        numWrongLabel.text = String(10 - numCorrect)
        scoreLabel.text = String(100 * numCorrect)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func restartGame(sender: AnyObject) {
        score = 0
        numQuestion = 0
        restartGame()
    }
    
    @IBAction func goToMenu(sender: AnyObject) {
        score = 0
        numQuestion = 0
        type = ""
        performSegueWithIdentifier("MainMenu", sender: sender)
    }
    
    func restartGame (){
        if(type == "Multiple Choice Factor")
        {
            performSegueWithIdentifier("restartMCF", sender: self)
        }
        else if(type == "User Input Factor")
        {
            performSegueWithIdentifier("restartUIF", sender: self)
        }
        else if(type == "Multiple Choice Graph")
        {
            performSegueWithIdentifier("restartMCG", sender: self)
        }
        else if(type == "User Input Graph")
        {
            performSegueWithIdentifier("restartUIG", sender: self)
        }
        else if(type == "Multiple Choice Trig")
        {
            performSegueWithIdentifier("restartMCT", sender: self)
        }
        else if(type == "User Input Right Triangle")
        {
            performSegueWithIdentifier("restartUIR", sender: self)
        }
        else if(type == "User Input Sine Cosine")
        {
            performSegueWithIdentifier("restartUISC", sender: self)
        }
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
            mcvc.numCorrect = score
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
