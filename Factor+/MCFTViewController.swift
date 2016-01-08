//
//  MCFTViewController.swift
//  Factor+
//
//  Created by Leo Yoon on 2016-01-07.
//  Copyright © 2016 LYM. All rights reserved.
//

import Foundation
import UIKit

class MultipleChoiceTimerViewController: UIViewController {
    
    var numQuestions = Int()
    
    @IBOutlet var choiceButtons: Array<UIButton>?
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressMCFT: UIProgressView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var coverUpButton: UIButton!
    @IBOutlet weak var pauseImage: UIImageView!
    
    var firstFactor: String = ""        //the first factor
    var secondFactor: String = ""       //the second factor
    var k: Int = 0
    var j: Int = 0
    var choice = [String]()             //this array stores each of the randomly generated answers
                                        //for the multiple choice question
    var rightAnsIndex: Int = 0          //the index in the array that stores the correct answer
    var numCorrect: Int = 0             //the number of questions that were correct
    var question: String = ""           //the variable that stores the question
    var fromPause: Bool = false         //was the "continue" button pressed from the pause menu?
    var basicFactor = Bool()            //is the quadratic relation basic or advanced?
    var timeRemaining: Int = 30
    var timer = NSTimer()
    var repeatTimer = NSTimer()
    
    //Step 1 (but only occurs once unless pause is activated)
    //when this screen is loaded, the following occurs:
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var temp = Double(numQuestions)/10
        progressMCFT.setProgress(Float(temp), animated: false)   //the progress bar is set, anywhere from 0% to 90%
        //depending on the progress of the game at the point
        //which the screen was loaded at
        coverUpButton.hidden = true                             //hide the disabler to begin
        
        //if the screen is loaded from the Pause menu
        if (fromPause == true) {
            
            questionLabel.text = question                           //set the questionLabel to the preserved question
            choiceButtons![0].setTitle(choice[0], forState: .Normal)    //then set each of the buttons to the corresponding
            choiceButtons![1].setTitle(choice[1], forState: .Normal)    //answer choices that were preserved
            choiceButtons![2].setTitle(choice[2], forState: .Normal)
            choiceButtons![3].setTitle(choice[3], forState: .Normal)
            
            timer = NSTimer.scheduledTimerWithTimeInterval(Double(timeRemaining), target: self, selector: "thirtySeconds:", userInfo: nil, repeats: false)
            
            repeatTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondPassed:", userInfo: nil, repeats: true)
            
            timerLabel.text = String(timeRemaining)
        }
            //if the screen is NOT loaded from the Pause menu
            //so if this is a fresh game
        else {
            
            makeQuestion()       //make a new question
            makeMultipleChoice() //make new and random multiple choice answers
            selectionSort()      //determine the rightAnsIndex
            assignToButtons()    //update the buttons for answer choices
            
            timer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: "thirtySeconds:", userInfo: nil, repeats: false)
            
            repeatTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondPassed:", userInfo: nil, repeats: true)
        }
        
    }
    
    //step 2-1
    //the question to be factored is made here
    //this func may change in the future to accommodate for advanced factoring where a > 1
    func makeQuestion() {
        
        var quadraticRelation = quadratic(fromUI: false, numCorrect: numCorrect) //the quadratic object, which generates a quadratic relation
        
        question = quadraticRelation.getExpression()    //use an accessor method to get the question
        
        questionLabel.text = question //set the questionLabel to display the question
        
        firstFactor = String(quadraticRelation.getMValue())     //access the first factor and second
        secondFactor = String(quadraticRelation.getNValue())    //factor with an accessor method
        k = quadraticRelation.getK()
        j = quadraticRelation.getJ()
        basicFactor = quadraticRelation.isBasicQuadratic()
        
    }
    
    //step 2-2
    //make the Multiple Choice system
    func makeMultipleChoice() {
        
        var finalAns = ""           //stores correct answer
        var i: Int = 0              //i and a are forloop counters
        var a: Int = 0
        
        for ( a = 0; a <= 3; a++) {
            choice.insert("", atIndex: a)   //fill in the array with blanks
        } //end of forloop
        
        let formatter = multipleChoice() //multipleChoice object that is used to format
        
        let kS: String = String(k)
        let jS: String = String(j)
        
        choice.removeAtIndex(0) //remove the value at first index,
        
        if (basicFactor == true) {
            let rS: String = formatter.getRAns(-1 * Int(firstFactor)!)  //the formatted versions of the
            let sS: String = formatter.getSAns(-1 * Int(secondFactor)!) //first and second factors to be
            //used to display
            
            choice.insert("(x"+rS+")(x"+sS+")", atIndex: 0) //and then fill it with the correct one
        }
        else {
            let rS: String = formatter.getRAns(Int(firstFactor)!)  //the formatted versions of the
            let sS: String = formatter.getSAns(Int(secondFactor)!) //first and second factors to be
            let kS: String = formatter.getKAns(k)
            let jS: String = formatter.getJAns(j)
            
            //used to display
            
            choice.insert("("+kS+"x"+rS+")("+jS+"x"+sS+")", atIndex: 0) //and then fill it with the correct one
        }
        finalAns = choice[0]
        
        for (i = 1; i <= 3; i++) //for 3 times - which is excluding the 0th index
        {
            
            //the various types of answers to be displayed
            //added after Beta Test (December 9th)
            var randomTypeOfAns = Int(arc4random_uniform(3) + 1)
            
            //completely random answer
            if(randomTypeOfAns == 1) {
                
                formatter.r = Int(arc4random_uniform(19) + 1) - 10 //get random number between -9 ~ 9
                formatter.s = Int(arc4random_uniform(19) + 1) - 10
                
                //both brackets will be equal in magnitude relative to the correct answer, but one of them will be different in signs
            } else if(randomTypeOfAns == 2) {
                
                formatter.r = -1 * Int(firstFactor)!
                formatter.s = Int(secondFactor)!
                
            } else if(randomTypeOfAns == 3) {
                
                //both brackets will be equal in magnitude relative to the correct answer, but different in signs
                formatter.r = -1 * Int(firstFactor)!
                formatter.s = -1 * Int(secondFactor)!
                
                //same as randomTypeOfAns == 2
            } else {
                
                formatter.r = Int(firstFactor)!
                formatter.s = -1 * Int(secondFactor)!
                
            }
            
            //if the index of the array is blank (not filled yet)
            if (choice[i] == "") {
                
                //fill it with one of the randomly generated 'r' and 's' values from above
                if (basicFactor == true) {
                    choice[i] = "(x"+formatter.getRAns(formatter.r)+")(x"+formatter.getSAns(formatter.s)+")"
                }
                else {
                    choice[i] = "("+formatter.getKAns(k)+"x"+formatter.getRAns(formatter.r)+")("+formatter.getJAns(j)+"x"+formatter.getSAns(formatter.s)+")"
                }
                
                //if the second index is being filled
                if (i == 1) {
                    
                    //check to see that it doesn't equal the 0th index
                    //this is to prevent multiple choices displaying the same answer
                    if(choice[i] == choice[0]) {
                        
                        //if so remove that and blank it
                        choice.removeAtIndex(i)
                        choice.insert("", atIndex: i)
                        i-- //i would equal the same thing once the forloop ends, since
                        //i increments each time the forloop ends
                        
                    } //end of 'if' statement
                }
                    //same logic as above
                else if (i == 2) {
                    
                    //this time check 0th and 1st index
                    if(choice[i] == choice[0] || choice[i] == choice[1]) {
                        
                        choice.removeAtIndex(i)
                        choice.insert("", atIndex: i)
                        i--
                    } //end of 'if' statement
                }
                    //same logic as above
                else if (i == 3) {
                    
                    //check all but the 3rd index
                    if(choice[i] == choice[0] || choice[i] == choice[1] || choice[i] == choice[2]) {
                        
                        choice.removeAtIndex(i)
                        choice.insert("", atIndex: i)
                        i--
                    } //end of 'if' statement
                } //end of the duplicate check 'else if' statements
                
            } //end of the blank check 'if' statement
            
        } //end of forloop that generates multiple choice
        
    } //end of makeMultipleChoice func
    
    //step 2-3
    //responsible for assigning the correct answer to a random index
    func selectionSort() {
        
        var rightAns: String = choice [0] //the right answer is stored in the first index thanks to
        //the makeMultipleChoice() func
        choice.removeAtIndex(0)           //remove the value for now
        
        rightAnsIndex = 4 - Int(arc4random_uniform (4) + 1) //pick a random index to store the correct answer in
        choice.insert(rightAns, atIndex: rightAnsIndex)     //then insert the value in the array
        
    } //end of selectionSort func
    
    //step 2-4
    //responsible for updating the UI for the buttons
    func assignToButtons() {
        
        //set each button's text to display the answer choices saved in choice[String]
        self.choiceButtons![0].setTitle(choice[0], forState: .Normal)
        self.choiceButtons![1].setTitle(choice[1], forState: .Normal)
        self.choiceButtons![2].setTitle(choice[2], forState: .Normal)
        self.choiceButtons![3].setTitle(choice[3], forState: .Normal)
        
    } //end of assignToButtons func

    func buttonClicked(buttonIndex: Int) {
        
        timer.invalidate()
        repeatTimer.invalidate()
        
        if (checkForRightAnswer(buttonIndex) == true) {
            
            choiceButtons![buttonIndex].backgroundColor = UIColor.greenColor()    //if correct, set the button to green
            numCorrect++                                            //increment number of answers correctly chosen
        }
        else { //if choice 1 is incorrect
            
            choiceButtons![buttonIndex].backgroundColor = UIColor.redColor()      //if incorrect, set the button to red
            
            //then check every other answer to see if they are correct, and highlight the correct answer in green
            choiceButtons![rightAnsIndex].backgroundColor = UIColor.greenColor()
            
        }
        
        nextButton.hidden = false       //show the 'next' button
        pauseButton.hidden = true       //hide the 'pause' button to prevent the question from resetting
        coverUpButton.hidden = false    //show the 'coverUp' button which is to prevent other answer buttons from
        //being clicked once the question is answered
        pauseImage.hidden = true        //hide the 'pause' image as well
        
    }
    
    @IBAction func choice1Clicked(sender: AnyObject) {
        
        buttonClicked(0)
    }
    
    @IBAction func choice2Clicked(sender: AnyObject) {
        
        buttonClicked(1)
    }
    
    @IBAction func choice3Clicked(sender: AnyObject) {
        
        buttonClicked(2)
    }
    
    @IBAction func choice4Clicked(sender: AnyObject) {
        
        buttonClicked(3)

    }
    
    //step 3-2
    //checks for whether the user clicked the right answer or not, returns a "true" or "false" Bool
    func checkForRightAnswer(buttonNumber: Int) -> Bool
    {
        //if the user chose the correct answer
        if ((buttonNumber) == rightAnsIndex) { //button numbers range from 1 ~ 4, and rightAnsIndex ranges from 0 ~ 3
            //hence the subtraction of 1
            return true     //return true
        }
            //if the user's choice is incorrect
        else {
            
            return false    //return false
        } //end of 'if else' statement
        
    } //end of checkForRightAnswer func
    
    //step 4
    //run this code when the next button is clicked
    //in essence, these codes occur when generating the next question
    
    @IBAction func nextButtonClicked(sender: AnyObject) {
        
        resetColours()              //resets the colour pattern of buttons to usual state
        changeProgress()            //change the progress bar's status
        makeQuestion()              //make a new quadratic relation and a question to be factored
        makeMultipleChoice()        //randomly generate multiple choice answers
        selectionSort()             //insert the correct answer to a random index
        assignToButtons()           //change text of buttons to the random answers, including a correct one
        pauseButton.hidden = false  //show the pause button
        nextButton.hidden = true    //hide the next button
        coverUpButton.hidden = true //hide the disabler
        pauseImage.hidden = false   //show the pause image
        timeRemaining = 30
        timerLabel.text = String(timeRemaining)
        timer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: "thirtySeconds:", userInfo: nil, repeats: false)
        repeatTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondPassed:", userInfo: nil, repeats: true)
    }
    
    //step 5-1
    //responsible for reverting the button's colours to default at the start of each question
    func resetColours() {
        
        //constant pink colour after Jan. 5
        choiceButtons![0].backgroundColor = UIColor(red: 222/255.0, green: 168/255.0, blue: 160/255.0, alpha: 1.0)
        choiceButtons![1].backgroundColor = UIColor(red: 222/255.0, green: 168/255.0, blue: 160/255.0, alpha: 1.0)
        choiceButtons![2].backgroundColor = UIColor(red: 222/255.0, green: 168/255.0, blue: 160/255.0, alpha: 1.0)
        choiceButtons![3].backgroundColor = UIColor(red: 222/255.0, green: 168/255.0, blue: 160/255.0, alpha: 1.0)
        
    } //end of resetColours func
    
    //step 5-2
    //responsible for changing the progress bar
    func changeProgress() {
        
        numQuestions++                                       //increment the number of questions answered
        var temp = Double(numQuestions)/10                   //the temp variable to be used for the progress bar
        progressMCFT.setProgress(Float(temp), animated: true) //set the progress bar
        
        if (numQuestions == 10) { //if 10 questions are completed
            
            endGame()             //call the endGame func
            
        } //end of 'if' statement
        
    } //end of changeProgress func
    
    //step 6 (when 10 cycles of step (1) - 5 is complete)
    //when 10 questions have been answered,
    func endGame() {
        
        performSegueWithIdentifier("endMCFT", sender: self) //proceed to the EndViewController
        
    } //end of endGame func
    
    @IBAction func pauseClicked(sender: AnyObject) {
        
        performSegueWithIdentifier("pauseMCFT", sender: sender)  //proceed to the PauseViewController

    }

    //just a default func, there should be no chance of insufficient memory
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    } //end of didReceiveMemoryWarning func
    
    //funcs that do the transition from one screen to another
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        //if the Pause button is clicked, this will load
        if(segue.identifier == "pauseMCFT") {
            
            let pvc = segue.destinationViewController as! PauseViewController //call the PauseViewController
            
            //pass on the following values to be preserved for when the game is resumed
            pvc.score = numCorrect
            pvc.numQuestion = numQuestions
            pvc.type = "Multiple Choice Factor Timer"
            pvc.factorOne = firstFactor
            pvc.factorTwo = secondFactor
            pvc.question = question
            pvc.rightAnswerIndex = rightAnsIndex
            pvc.timeRemaining = timeRemaining
            
            //also pass on the values stored in choice[String], so that the multiple choice can be replicated
            //again without creating new choices
            for (var i = 0; i <= 3; i++) {
                
                pvc.multipleChoiceChoices.insert(choice[i], atIndex: i)
            }
        } //end of 'if' statement for PauseViewController
            
            //step 7
            //if the endGame() func is called, this will load
        else if(segue.identifier == "endMCFT") {
            
            let evc = segue.destinationViewController as! EndViewController //call the EndViewController
            evc.numCorrect = numCorrect
            evc.type = "Multiple Choice Factor Timer"
        } //end of 'else if' statement for EndViewController
        
    } //end of prepareForSegue func
    
    //here code perfomed with delay (30 seconds in this case)
    func thirtySeconds(timer: NSTimer) {
        
        if (checkForRightAnswer(1) == true) {
            choiceButtons![0].backgroundColor = UIColor.greenColor()
        }
            
        else if (checkForRightAnswer(2) == true) {
            choiceButtons![1].backgroundColor = UIColor.greenColor()
        }
            
        else if (checkForRightAnswer(3) == true) {
            choiceButtons![2].backgroundColor = UIColor.greenColor()
        }
            
        else if (checkForRightAnswer(4) == true) {
            choiceButtons![3].backgroundColor = UIColor.greenColor()
        }
        
        nextButton.hidden = false
        pauseButton.hidden = true
        coverUpButton.hidden = false
        pauseImage.hidden = true
        
        repeatTimer.invalidate()
        timerLabel.text = "Time Up"
    }
    
    func secondPassed(repeatTimer: NSTimer) {

        timeRemaining--
        timerLabel.text = String(timeRemaining)
    }

}