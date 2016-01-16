//
//  UIFViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-10-27.
//  Copyright © 2015 LYM. All rights reserved.
//
//  This class displays the User Input: Factoring screen.
//  In this file, the application generates a quadratic relation to be factored, by using
//  the quadratic class, and making an object of the class. Then the user controls the sliders
//  to generate a correct answer.
//
//  This file, as with all other files, is linked to various other View Controllers (screens)
//  such as the Pause screen or the End screen, to enable a progress in the application.
//
//  * Work distribution
//  Taehyun: responsible for the creation of the class and setting up the skeletons of the class
//           such as the endGame(), viewDidLoad(), prepareForSegue(), etc.
//  Leo: responsible for thoroughly commenting the class, and completing other funcs such as the
//       nextButtonClicked() as well as integrating all of the pieces together
//

import UIKit

class UIFViewController: UIViewController {
    
    //initializing UI objects from the UIF (User Input Factor) view controller by declaring them as an outlet.
    
    /*
    * sliderM: (x - m)(x - n)
    * sliderN: the sliders control the variables
    * enterButton: the Enter button
    * progressUIF: the progress bar
    * pauseButton: the Pause button
    * questionLabel: displays the question
    * rightOrWrong: shows either a check mark or a X
    * nextButton: the Next button
    * pauseImage: just an image of the pause symbol, the actual button hitbox is larger
    */
    @IBOutlet weak var sliderM: UISlider!
    @IBOutlet weak var sliderN: UISlider!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var progressUIF: UIProgressView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var rightOrWrong: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pauseImage: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    
    /*
    * ttlScore: the number of correct answers
    * numQuestions: questions answered so far
    * currentM: the current value of sliderM
    * currentN: the current value of sliderN
    * firstFactor: one of the two factors
    * secondFactor: other one of the two factors
    * fromPause: is the screen loaded from pause screen?
    * question: the variable that stores the question
    */
    var ttlScore = Int(), numQuestions = Int(), currentM = Int(), currentN = Int()
    var firstFactor: String = ""
    var secondFactor: String = ""
    var fromPause: Bool = false
    var question: String = ""
    
    //When the view loads, ie: when game mode is selected
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //set the progress bar
        var temp = Double(numQuestions)/10
        progressUIF.setProgress(Float(temp), animated: false)
        
        //if the view loaded from the Pause Menu
        if (fromPause == true) {
            
            //set the question and the sliders according to the saved parameters
            questionLabel.text = question
            sliderM.setValue(Float (currentM), animated: false)
            sliderN.setValue(Float (currentN), animated: false)
            
            //run this so that the answerLabel is correctly formatted
            valChanged()
            
        }
        else {
            
            //if not, just make a new question
            makeQuestion()
        }
    }
    
    func makeQuestion(){
        
        //make a new quadratic relation 
        //send in true for fromUserInput, and default to 0 correct answers because UIF doesn't support advacned factoring
        var quadraticRelation = quadratic(fromUI: true, numCorrect: 0)
        
        //reset sliders to default
        sliderM.setValue(Float (0), animated: false)
        sliderN.setValue(Float (0), animated: false)
        
        //reset answerLabel text to default
        answerLabel.text = "( x - m ) ( x - n )"
        
        //set the question, and store the factors in variables (to be used for checking answer)
        question = quadraticRelation.getExpression()
        questionLabel.text = question
        firstFactor = String(quadraticRelation.getMValue())
        secondFactor = String(quadraticRelation.getNValue())
    }
    
    //runs when Enter button is clicked
    @IBAction func changeProgress(sender: AnyObject) {
        
        //check for answer, and show/hide appropriate buttons
        checkAnswer()
        nextButton.hidden = false
        enterButton.hidden = true
        pauseButton.hidden = true
        pauseImage.hidden = true
    }

    //declaring and initializing a function of the sliders within the view controller.
    //source to the code: https://www.youtube.com/watch?v=jJA9UCbcos0
    //runs when sliderM is changed
    @IBAction func valChangeM(sender: AnyObject) {
        
        valChanged()
    }
    
    //runs when sliderN is changed
    @IBAction func valChangeN(sender: AnyObject) {

        valChanged()

    }
    
    //all slider changes are redirected to here
    //all formatting for the label is done in here
    func valChanged() {
        
        //the current M, N value - doesn't change
        currentM = Int(sliderM.value)
        currentN = Int(sliderN.value)
        
        //a temporary M value to be used for formatting
        var tempCurrentM = String(currentM)
        
        if (currentM < 0) {
            
            tempCurrentM = "(x + \(abs(currentM)))" //(x + m)
        }
        else if (currentM > 0) {
            
            tempCurrentM = "(x - \(currentM))"      //(x - m)
        }
        else {
            
            tempCurrentM = "x"                      //x
        }
        
        //a temporary N value to be used for formatting
        var tempCurrentN = String(currentN)
        
        if (currentN < 0) {
            
            tempCurrentN = "(x + \(abs(currentN)))"
        }
        else if (currentN > 0) {
            
            tempCurrentN = "(x - \(currentN))"
        }
        else {
            
            tempCurrentN = "x"
        }
        
        if (currentM == 0 && currentN == 0) {
            answerLabel.text = "x²" //x² is when both factors are 0
            
            if (fromPause == true) {
                
                //if view loaded from pause, AND both sliders are 0, reset the label
                answerLabel.text = "( x - m ) ( x - n )"
            }
        }
        else {
            
            //finally, use the formatted variables to make the answerLabel
            answerLabel.text = ("\(tempCurrentM) \(tempCurrentN)")
        }
        
    }
    
    //when next button is clicked
    @IBAction func nextButtonClicked(sender: AnyObject) {
        
        //change progress bar
        numQuestions++
        var temp = Double(numQuestions)/10
        progressUIF.setProgress(Float(temp), animated: true)
       
        //check if game ended, and make new question if not
        endGame()
        makeQuestion()
        
        //hide/show the buttons necessary
        nextButton.hidden = true
        rightOrWrong.hidden = true
        enterButton.hidden = false
        pauseButton.hidden = false
        pauseImage.hidden = false
    }
    
    //check user's answer with the correct answer
    func checkAnswer(){
        
        //two cases of correct answer
        //this is because there are two ways to input a correct answer
        //ex: (x-3)(x+5) is same as (x+5)(x-3)
        if (Int(firstFactor) == (Int(sliderM.value)) && Int(secondFactor) == (Int(sliderN.value))) {
            
            ttlScore++
            rightOrWrong.image = UIImage(named: "Check Mark")
        }
        else if (Int(firstFactor) == (Int(sliderN.value)) && Int(secondFactor) == (Int(sliderM.value))) {
            
            ttlScore++
            rightOrWrong.image = UIImage(named: "Check Mark")
        }
        else { //display X for incorrect answer
            
            rightOrWrong.image = UIImage(named: "X Mark")
        }
        
        //reveal image to display answer
        rightOrWrong.hidden = false;
    }

    func endGame() {
        
        //if 10 questions were answered, end game
        if(numQuestions == 10) {
            
            performSegueWithIdentifier("endUIF", sender: self)
        }
    }
    
    //go to pause menu when pause button is clicked
    @IBAction func pauseClicked(sender: AnyObject) {
        
        performSegueWithIdentifier("pauseUIF", sender: sender)
    }
    
    //should never run
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //Segues: links to other screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //if segue is linked to pause,
        if(segue.identifier == "pauseUIF") {
            
            //send over all parameters that need to be stored
            let pvc = segue.destinationViewController as! PauseViewController
            pvc.score = ttlScore
            pvc.numQuestion = numQuestions
            pvc.type = "User Input Factor"
            pvc.factorOne = firstFactor
            pvc.factorTwo = secondFactor
            pvc.question = question
            pvc.currentM = Int(sliderM.value)
            pvc.currentN = Int(sliderN.value)

        }
        //if segue is linked to end, go to the End Screen
        else if(segue.identifier == "endUIF") {
            
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "User Input Factor"
        }
    }

}
