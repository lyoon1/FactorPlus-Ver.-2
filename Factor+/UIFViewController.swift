//
//  UIFViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-10-27.
//  Copyright © 2015 LYM. All rights reserved.
//
//  This class displays the User Input: Factoring screen.
//  In this file, the application generates a quadratic relations to be factored, by using
//  the quadratic class, and making an object of the class. Then multiple choice answers are
//  generated by using the values derived from the quadratic relation.
//
//  This file, as with all other files, is linked to various other View Controllers (screens)
//  such as the Pause screen or the End screen, to enable a progress in the application.
//
//  * Work distribution
//  Taehyun: responsible for the creation of the class and setting up the skeletons of the class
//           such as the endGame(), viewDidLoad(), prepareForSegue(), etc.
//  Leo: responsible for thoroughly commenting the class, and completing other funcs such as the
//       resetColours() or checkForRightAnswer() as well as integrating all of the pieces together
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
    
    @IBAction func pauseClicked(sender: AnyObject) {
        
        performSegueWithIdentifier("pauseUIF", sender: sender)
    }
    
    //question label
    @IBOutlet weak var label: UILabel!
    
    @IBAction func changeProgress(sender: AnyObject) {
        
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
            
            tempCurrentM = "(x + \(abs(currentM)))"
        }
        else if (currentM > 0) {
            
            tempCurrentM = "(x - \(currentM))"
        }
        else {
            
            tempCurrentM = "x"
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
            label.text = "x²"
            
            if (fromPause == true) {
                
                label.text = "( x - m ) ( x - n )"
            }
        }
        else {
            label.text = ("\(tempCurrentM) \(tempCurrentN)")
        }
        
    }
    
    //when next button is clicked
    @IBAction func nextButtonClicked(sender: AnyObject) {
        
        numQuestions++
        var temp = Double(numQuestions)/10
        progressUIF.setProgress(Float(temp), animated: true)
        endGame()
        makeQuestion()
        
        //hide/show the buttons necessary
        nextButton.hidden = true
        rightOrWrong.hidden = true
        enterButton.hidden = false
        pauseButton.hidden = false
        pauseImage.hidden = false
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var temp = Double(numQuestions)/10
        progressUIF.setProgress(Float(temp), animated: false)
        
        if (fromPause == true) {
            
            questionLabel.text = question
            sliderM.setValue(Float (currentM), animated: false)
            sliderN.setValue(Float (currentN), animated: false)
            
            valChanged()
            
        }
        else {
            
            makeQuestion()
        }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func makeQuestion(){
        
        var quadraticRelation = quadratic(fromUI: true, numCorrect: 0)
        
        sliderM.setValue(Float (0), animated: false)
        sliderN.setValue(Float (0), animated: false)
        
        label.text = "( x - m ) ( x - n )"

        question = quadraticRelation.getExpression()
        questionLabel.text = question
        firstFactor = String(quadraticRelation.getMValue())
        secondFactor = String(quadraticRelation.getNValue())
    }
    
    func checkAnswer(){
        
        if (Int(firstFactor) == (Int(sliderM.value)) && Int(secondFactor) == (Int(sliderN.value))) {
            ttlScore++
            rightOrWrong.image = UIImage(named: "Check Mark")
        }
        else if (Int(firstFactor) == (Int(sliderN.value)) && Int(secondFactor) == (Int(sliderM.value))) {
            ttlScore++
            rightOrWrong.image = UIImage(named: "Check Mark")
        }
        else {
            rightOrWrong.image = UIImage(named: "X Mark")
        }
        
        rightOrWrong.hidden = false;
    }

    func endGame() {
        
        if(numQuestions == 10) {
            
            performSegueWithIdentifier("endUIF", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "pauseUIF") {
            
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
        else if(segue.identifier == "endUIF") {
            
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "User Input Factor"
        }
    }

}
