//
//  EndViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-05.
//  Copyright © 2015 LYM. All rights reserved.
//
//  The end screen of the program, appears after 10 questions of a game mode.
//
//  Displays the following:
//      Number of correct answers
//      Number of incorrect answers
//      The score for the play performed & previous highscore
//      Type of the game mode performed
//      Navigation - Restart/Menu buttons
//      Time elapsed
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

    //runs when Restart button clicked
    @IBAction func restartGame(sender: AnyObject) {
        
        //reset all counters and restart
        score = 0
        numQuestion = 0
        restartGame()
    }
    
    //runs when Menu button clicked
    @IBAction func goToMenu(sender: AnyObject) {
        
        //reset all counters and go to menu
        score = 0
        numQuestion = 0
        type = ""
        performSegueWithIdentifier("MainMenu", sender: sender)
    }
    
    //select the corresponding Segue
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
    
    //Runs when Menu button is clicked
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "MainMenu")
        {
            let mvc = segue.destinationViewController as! StartViewController
        }
            
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

}
