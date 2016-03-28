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
//  It can continue or restart to a certain game mode, or go to the main menu.

import UIKit

class PauseViewController: UIViewController {
    
    //the three buttons on the Pause screen
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!

    var restarting: Bool = false //boolean value that will be true if the set game will restart and false if the set game will continue
    var numQuestion = Int() //current question number value
    var score = Int() //current score value
    var type = String() //value that saves the type of game mode pause screen is called from
    var factorOne = String() //current first factor
    var factorTwo = String() //current second factor
    var question = String() //current question label
    var multipleChoiceChoices = [String]() //current multiple choice choices in the right order
    var rightAnswerIndex = Int() //index value of the correct multiple choice choice
    var currentM = Int() //current value of sliderM
    var currentN = Int() //current value of sliderN
    var currentA = Int() //current value of sliderA
    var currentH = Int() //current value of sliderH
    var currentK = Int() //current value of sliderK
    var xval = [String]() //current x-value for the LineChartGraph
    var yval = [Double]() //current y-value for the LineChartGraph
    var graphPoint = [GraphingPoints]() //current graphPoint for UIGViewController
    var timeRemaining = Int()
    var timeTaken = Int()
    
    @IBAction func restartGame(sender: AnyObject) { //if restart button pressed, score and question number is set to zero, and restarting is set to true
        score = 0
        numQuestion = 0
        restarting = true
        continueToGame()
    }
    @IBAction func continueGame(sender: AnyObject) { //when continue button pressed, no values are set to zero and proceeds to continueToGame()
        
        continueToGame()
    }
    @IBAction func goToMenu(sender: AnyObject) { //when main menu button pressed, score, number of question, and type is set to zero or "" and proceeds stright to perform segue method
        score = 0
        numQuestion = 0
        type = ""
        performSegueWithIdentifier("MainMenu", sender: sender)
    }
    
    func continueToGame (){ //according to type, the program proceeds to perform segue with the corresponding identifier
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
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { //method that takes in an identifier and proceeds to do the corresponding segue
        
        if(segue.identifier == "MainMenu") { //when identifier is MainMenu, it will load up the StartViewController
            
            let svc = segue.destinationViewController as! StartViewController
        }
        
        //if the identifier is a gamemode, it will load up the corresponding gamemode screen
        else if(segue.identifier == "Continue MCF") {
            
            let mcvc = segue.destinationViewController as! MultipleChoiceViewController
            mcvc.numCorrect = score
            mcvc.numQuestions = numQuestion
            
            if (restarting == false) { //if restarting is false, the game sets all the necassary variables to the stored value
            
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
    }
}
