//
//  EndViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-05.
//  Copyright © 2015 LYM. All rights reserved.
//
//  The end screen of the program.
//
//  
//
//
//
//

import UIKit

class EndViewController: UIViewController {
    
    /*
    * numCorrect -> number of correct answers
    * type -> the name of the game mode
    * score -> the score achieved through correct answers
    * numQuestion -> number of questions answered - reset to zero from this screen
    * highScore -> stored highscore
    * timeTaken -> time elapsed
    */
    var numCorrect = Int(), type = String(), score = Int(), numQuestion = Int(), highScore = Int(), timeTaken = Int()
    
    @IBOutlet weak var questionTypeLabel: UILabel!      //displays the type of question
    @IBOutlet weak var numCorrectLabel: UILabel!        //displays number of correct answers
    @IBOutlet weak var numWrongLabel: UILabel!          //displays number of wrong answers
    @IBOutlet weak var scoreLabel: UILabel!             //displays the score in %
    @IBOutlet weak var timeLabel: UILabel!              //displays the time elapsed
    @IBOutlet weak var highScoreLabel: UILabel!         //displays the highscore for the game mode
    @IBOutlet weak var restartButton: UIButton!         //the restart button
    @IBOutlet weak var menuButton: UIButton!            //the main menu button
    @IBOutlet weak var questionTypeImage: UIImageView!  //the image that displays the game mode
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //set the image and text based on the game mode performed
        questionTypeImage.image = UIImage(named: type)
        questionTypeLabel.text = type
        
        //set the score labels based on numCorrect
        numCorrectLabel.text = String(numCorrect)
        numWrongLabel.text = String(10 - numCorrect)
        scoreLabel.text = "\(10 * numCorrect)%"
      
        //ONLY display the timer if it's timer mode
        if (type == "Multiple Choice Factor Timer") {
            
            timeLabel.text = "Time Elapsed: \(timeTaken) seconds"
            timeLabel.hidden = false
            
        }
        
        let prevHighScore = NSUserDefaults.standardUserDefaults()
        
        if (prevHighScore.valueForKey(type) != nil) {
            
            highScore = prevHighScore.valueForKey(type) as! NSInteger
        }
        
        if (highScore < numCorrect) {
            
            highScore = numCorrect
        }
        
        let highScoreString = "Highscore: \(highScore*10)%"
        highScoreLabel.text = highScoreString
        
        prevHighScore.setValue(highScore, forKey: type)
        
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
        else if(type == "Multiple Choice Factor Timer")
        {
            performSegueWithIdentifier("restartMCFT", sender: self)
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
            
        //The codes below are not part of the ICS4U project
        //they will be used when(if) Trigonometry gets implemented
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
            let mvc = segue.destinationViewController as! StartViewController
        }
        else if(segue.identifier == "Continue MCF")
        {
            let mcvc = segue.destinationViewController as! MultipleChoiceViewController
            mcvc.numCorrect = score
            mcvc.numQuestions = numQuestion
        }
        else if(segue.identifier == "Continue MCFT")
        {
            let mcftvc = segue.destinationViewController as! MultipleChoiceTimerViewController
            mcftvc.numCorrect = score
            mcftvc.numQuestions = numQuestion
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
            
        //The codes below are not part of the ICS4U project
        //they will be used when(if) Trigonometry gets implemented
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
