//
//  MCFTViewController.swift
//  Factor+
//
//  Created by Leo Yoon on 2016-01-07.
//  Copyright © 2016 LYM. All rights reserved.
//
//  This class behaves exactly the same as MCFViewController.
//  The only difference is the timer system that will be commented on below.
//

import Foundation
import UIKit

class MultipleChoiceTimerViewController: UIViewController {
    
    var numQuestions = Int()                        //stores number of questions answered
    
    @IBOutlet var choiceButtons: Array<UIButton>?   //the UIButton array that stores the 4 answer buttons
    
    @IBOutlet weak var pauseButton: UIButton!       //the pause button
    @IBOutlet weak var questionLabel: UILabel!      //this UILabel displays the quadratic relation
    @IBOutlet weak var timerLabel: UILabel!         //this displays the time remaining in seconds
    @IBOutlet weak var progressMCFT: UIProgressView!//the progress bar, consists of 10 questions
    @IBOutlet weak var nextButton: UIButton!        //the next button, generates next question when
                                                    //clicked
    @IBOutlet weak var buttonFrame: UIImageView!    //the blue background behind the buttons
    @IBOutlet weak var coverUpButton: UIButton!     //this appears when an answer is clicked, as a
                                                    //means of disabling other buttons
    @IBOutlet weak var pauseImage: UIImageView!     //the green pause image
    
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
    var timeRemaining: Int = 30         //each question is given 30 seconds to answer
    var timeTaken = Int()               //how long did the user take in total?
    var timer = NSTimer()               //the 30 seconds timer
    var repeatTimer = NSTimer()         //repeats every second to update the timerLabel
    
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
            
            for (var i = 0; i < 4; i++) {
                
                //then set each of the buttons to the corresponding answer choices that were preserved
                choiceButtons![i].setTitle(choice[i], forState: .Normal)
                
            }
            
            //restart the timer with 'timeRemaining' seconds left
            timer = NSTimer.scheduledTimerWithTimeInterval(Double(timeRemaining), target: self, selector: "thirtySeconds:", userInfo: nil, repeats: false)
            
            //re-initialize the repeatTimer
            repeatTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondPassed:", userInfo: nil, repeats: true)
            
            timerLabel.text = String(timeRemaining) //update the timerLabel
            
        }
            //if the screen is NOT loaded from the Pause menu
            //so if this is a fresh game
        else {
            
            makeQuestion()       //make a new question
            makeMultipleChoice() //make new and random multiple choice answers
            selectionSort()      //determine the rightAnsIndex
            assignToButtons()    //update the buttons for answer choices
            
            //start the timers as soon as the view loads
            timer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: "thirtySeconds:", userInfo: nil, repeats: false)
            
            repeatTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondPassed:", userInfo: nil, repeats: true)
        }
        
    }
    
    //step 2-1
    //the question to be factored is made here
    //this func may change in the future to accommodate for advanced factoring where a > 1
    func makeQuestion() {
        
        var quadraticRelation = quadratic(numCorrect: numCorrect) //the quadratic object, which generates a quadratic relation
        
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
                
                /* If the multiple choice answer is completely different from the correct answer, it is compared to the rest of the
                * multiple choice answers in the choice array
                * This is done through the following for loop
                * If a single element in the choice array matches tempAns, the multiple choice answer will be erased and the i counter
                * will decrement to prevent the wasting of a turn
                *
                * Otherwise, the multiple choice answer will be added to the choice array
                */
                for (var checkAnyAns: Int = 0; checkAnyAns < i; checkAnyAns++) {
                    
                    //check to see that it doesn't equal the previous indexes
                    //this is to prevent multiple choices displaying the same answer
                    if (choice[i] == choice[checkAnyAns]){
                        
                        //if so remove that and blank it
                        choice.removeAtIndex(i)
                        choice.insert("", atIndex: i)
                        i-- //i would equal the same thing once the forloop ends, since
                        //i increments each time the forloop ends
                        
                    } //end of 'if' statement
                    
                } //end of forloop for duplicate check
                
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
        for (var i = 0; i < 4; i++) {
            
            choiceButtons![i].setTitle(choice[i], forState: .Normal)
            
        }
        
    } //end of assignToButtons func
    
    //step 3-1
    //when the user selects an answer, do one of these
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
    
    //this is ran when any button is clicked
    func buttonClicked(buttonIndex: Int) {
        
        //the timers stop when the user answers the question
        timer.invalidate()
        repeatTimer.invalidate()
        
        if (checkForRightAnswer(buttonIndex) == true) {
            
            choiceButtons![buttonIndex].backgroundColor = UIColor.greenColor()    //if correct, set the button to green
            numCorrect++                                                          //increment number of answers correctly chosen
        }
        else { //if choice 1 is incorrect
            
            choiceButtons![buttonIndex].backgroundColor = UIColor.redColor()      //if incorrect, set the button to red
            
            //then highlight the correct answer in green
            choiceButtons![rightAnsIndex].backgroundColor = UIColor.greenColor()
            
        }
        
        nextButton.hidden = false       //show the 'next' button
        buttonFrame.hidden = false       //show the buttonFrame
        pauseButton.hidden = true       //hide the 'pause' button to prevent the question from resetting
        coverUpButton.hidden = false    //show the 'coverUp' button which is to prevent other answer buttons from
                                        //being clicked once the question is answered
        pauseImage.hidden = true        //hide the 'pause' image as well
        
    }
    
    //step 3-2
    //checks for whether the user clicked the right answer or not, returns a "true" or "false" Bool
    func checkForRightAnswer(buttonNumber: Int) -> Bool
    {
        //if the user chose the correct answer
        if ((buttonNumber) == rightAnsIndex) {
            
            return true
        }
            //if the user's choice is incorrect
        else {
            
            return false
            
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
        buttonFrame.hidden = true  //hide the buttonFrame
        coverUpButton.hidden = true //hide the disabler
        pauseImage.hidden = false   //show the pause image
        timeTaken += (30 - timeRemaining) //increment time taken based on time remaining
        timeRemaining = 30          //reset time to 30 seconds
        timerLabel.text = String(timeRemaining) //reset the timerLabel
        
        //and restart both timers
        timer = NSTimer.scheduledTimerWithTimeInterval(30.0, target: self, selector: "thirtySeconds:", userInfo: nil, repeats: false)
        repeatTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "secondPassed:", userInfo: nil, repeats: true)
    }
    
    //step 5-1
    //responsible for reverting the button's colours to default at the start of each question
    func resetColours() {
        
        //constant pink colour for all buttons
        for (var i = 0; i < 4; i++) {
            
            choiceButtons![i].backgroundColor = UIColor(red: 222/255.0, green: 168/255.0, blue: 160/255.0, alpha: 1.0)
        }
        
    } //end of resetColours func
    
    //step 5-2
    //responsible for changing the progress bar
    func changeProgress() {
        
        numQuestions++                                        //increment the number of questions answered
        var temp = Double(numQuestions)/10                    //the temp variable to be used for the progress bar
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
    
    //when the pause button is clicked
    @IBAction func pauseClicked(sender: AnyObject) {
        
        performSegueWithIdentifier("pauseMCFT", sender: sender) //proceed to the PauseViewController

    } //end of pauseClicked func

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
            pvc.timeTaken = timeTaken
            
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
            evc.timeTaken = timeTaken
        } //end of 'else if' statement for EndViewController
        
    } //end of prepareForSegue func
    
    //here code perfomed with delay (30 seconds in this case)
    func thirtySeconds(timer: NSTimer) {
        
        //display the correct answer
        if (checkForRightAnswer(rightAnsIndex) == true) {
            
            choiceButtons![rightAnsIndex].backgroundColor = UIColor.greenColor()
        }
        
        //now the user can't choose another answer, and can only click 'next'
        nextButton.hidden = false
        buttonFrame.hidden = false
        pauseButton.hidden = true
        coverUpButton.hidden = false
        pauseImage.hidden = true
        
        //stop the repeating timer and set the timerLabel text to let the user know "time up"
        repeatTimer.invalidate()
        timerLabel.text = "Time Up"
        
    } //end of thirtySeconds func
    
    //do this each second
    func secondPassed(repeatTimer: NSTimer) {

        //one less second, and update the label to reflect that
        timeRemaining--
        timerLabel.text = String(timeRemaining)
    }

} //end of class