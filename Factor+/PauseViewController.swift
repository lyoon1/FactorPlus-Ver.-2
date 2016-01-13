//
//  PauseViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-02.
//  Copyright © 2015 LYM. All rights reserved.
//
//  The class that stores all data for the Pause Menu.
//
//  This class is linked from and to every game mode View Controller, with
//  variables that are needed in each of the game modes.
//

import UIKit

class PauseViewController: UIViewController {
    
    //the three buttons on the Pause screen
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!

    var restarting: Bool = false
    var numQuestion = Int()
    var score = Int()
    var type = String()
    var factorOne = String()
    var factorTwo = String()
    var question = String()
    var multipleChoiceChoices = [String]()
    var rightAnswerIndex = Int()
    var currentM = Int() //current value of sliderM
    var currentN = Int() //current value of sliderN
    var currentA = Int() //current value of sliderA
    var currentH = Int() //current value of sliderH
    var currentK = Int() //current value of sliderK
    var xval = [String]()
    var yval = [Double]()
    var graphPoint = [GraphingPoints]()
    var timeRemaining = Int()
    var timeTaken = Int()
    
    @IBAction func restartGame(sender: AnyObject) {
        score = 0
        numQuestion = 0
        restarting = true
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
        else if(type == "Multiple Choice Factor Timer")
        {
            performSegueWithIdentifier("Continue MCFT", sender: self)
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
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "MainMenu") {
            
            let svc = segue.destinationViewController as! StartViewController
        }
            
        else if(segue.identifier == "Continue MCF") {
            
            let mcvc = segue.destinationViewController as! MultipleChoiceViewController
            mcvc.numCorrect = score
            mcvc.numQuestions = numQuestion
            
            if (restarting == false) {
            
                mcvc.firstFactor = factorOne
                mcvc.secondFactor = factorTwo
                mcvc.question = question
                mcvc.rightAnsIndex = rightAnswerIndex
                mcvc.fromPause = true
            }
            for (var i = 0; i < 4; i++){
                mcvc.choice.insert(multipleChoiceChoices[i], atIndex: i)
            }
        }
        else if(segue.identifier == "Continue MCFT")
        {
            let mcftvc = segue.destinationViewController as! MultipleChoiceTimerViewController
            mcftvc.numCorrect = score
            mcftvc.numQuestions = numQuestion
            
            if (restarting == false) {
                
                mcftvc.firstFactor = factorOne
                mcftvc.secondFactor = factorTwo
                mcftvc.question = question
                mcftvc.rightAnsIndex = rightAnswerIndex
                mcftvc.timeRemaining = timeRemaining
                mcftvc.timeTaken = timeTaken
                mcftvc.fromPause = true
            }
            for (var i = 0; i < 4; i++){
                mcftvc.choice.insert(multipleChoiceChoices[i], atIndex: i)
            }
        }

        else if(segue.identifier == "Continue UIF")
        {
            let uifvc = segue.destinationViewController as! UIFViewController
            uifvc.numQuestions = numQuestion
            uifvc.ttlScore = score
            
            if (restarting == false) {
                
                uifvc.firstFactor = factorOne
                uifvc.secondFactor = factorTwo
                uifvc.question = question
                uifvc.currentM = currentM
                uifvc.currentN = currentN
                uifvc.fromPause = true
            }
        }
        else if(segue.identifier == "Continue MCG")
        {
            let mc2vc = segue.destinationViewController as! MultipleChoice2ViewController
            mc2vc.numQuestions = numQuestion
            mc2vc.ttlScore = score
            
            if (restarting == false) {
                
                mc2vc.rightAnsIndex = rightAnswerIndex
                mc2vc.fromPause = true
                
                for (var i = 0; i < 4; i++){
                    mc2vc.choice.insert(multipleChoiceChoices[i], atIndex: i)
                }
                
                for (var i = 0; i < 12; i++) {
                    mc2vc.xValues.insert(xval[i], atIndex: i)
                    mc2vc.yValues.insert(yval[i], atIndex: i)
                }

            }
        }
        else if(segue.identifier == "Continue UIG")
        {
            let uigvc = segue.destinationViewController as! UIGViewController
            uigvc.numQuestions = numQuestion
            uigvc.ttlScore = score
            
            if (restarting == false) {
                uigvc.numQuestions = numQuestion
                uigvc.currentA = currentA
                uigvc.currentH = currentH
                uigvc.currentK = currentK
                uigvc.fromPause = true
                
                for (var i = 0; i < 12; i++) {
                    uigvc.xValues.insert(xval[i], atIndex: i)
                    uigvc.yValues.insert(yval[i], atIndex: i)
                }
                
                uigvc.graphPoint.insert(graphPoint[0], atIndex: 0)
            }
            
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
