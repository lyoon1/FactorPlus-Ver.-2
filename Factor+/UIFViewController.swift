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
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var progressUIF: UIProgressView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var rightOrWrong: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var buttonFrame: UIImageView!
    @IBOutlet weak var pauseImage: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var buttonK: UIButton!
    @IBOutlet weak var buttonJ: UIButton!
    @IBOutlet weak var buttonM: UIButton!
    @IBOutlet weak var buttonN: UIButton!
    
    /*
    * ttlScore: the number of correct answers
    * numQuestions: questions answered so far
    * currentK, J, M, N: the current value of these variables
    * kValue, jValue: the answer values for 'k' and 'j'
    * firstFactor: one of the two factors
    * secondFactor: other one of the two factors
    * fromPause: is the screen loaded from pause screen?
    * question: the variable that stores the question
    * currentVar: what variable is being changed right now?
    */
    var ttlScore = Int(), numQuestions = Int(),  currentM = Int(), currentN = Int(), kValue = Int(), jValue = Int()
    var currentK: Int = 1
    var currentJ: Int = 1
    var firstFactor: String = ""
    var secondFactor: String = ""
    var fromPause: Bool = false
    var question: String = ""
    var currentVar: String = ""
    
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
            
            switch (currentVar) {
                
            case "k":
                sliderM.setValue(Float (currentK), animated: false)
                break;
                
            case "j":
                sliderM.setValue(Float (currentJ), animated:false)
                break;
                
            case "m":
                sliderM.setValue(Float (currentM), animated: false)
                break;
                
            case "n":
                sliderM.setValue(Float (currentN), animated: false)
                break;
                
            default:
                break;
                
            }
            
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
        var quadraticRelation = quadratic(numCorrect: ttlScore)
        
        //reset sliders to default
        sliderM.setValue(Float (0), animated: false)
        
        //reset answerLabel text to default
        answerLabel.text = "( kx - m ) ( jx - n )"
        
        //set the question, and store the factors in variables (to be used for checking answer)
        question = quadraticRelation.getExpression()
        questionLabel.text = question
        
        kValue = quadraticRelation.getK()
        jValue = quadraticRelation.getJ()
        
        if (kValue != 1 || jValue != 1) {
        
            firstFactor = String(-1 * quadraticRelation.getMValue())
            secondFactor = String(-1 * quadraticRelation.getNValue())
        }
        else {
            
            firstFactor = String(quadraticRelation.getMValue())
            secondFactor = String(quadraticRelation.getNValue())
        }
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
    //runs when slider is changed
    @IBAction func valChangeM(sender: AnyObject) {
        
        valChanged()
    }
    
    @IBAction func kClicked(sender: AnyObject) {
        
        currentVar = "k"
        if (currentK == 0) {
    
            sliderM.setValue(1, animated: false)
        }
        else {
            sliderM.setValue(Float(currentK), animated: false)
        }
        sliderM.hidden = false
        enterButton.hidden = false
        buttonFrame.hidden = false
        
        print(kValue)
        print(jValue)
        print(firstFactor)
        print(secondFactor)
        
    }
    
    @IBAction func jClicked(sender: AnyObject) {
        
        currentVar = "j"
        if (currentJ == 0) {
      
            sliderM.setValue(1, animated: false)
        }
        else {
            sliderM.setValue(Float(currentJ), animated: false)
        }
        sliderM.hidden = false
        enterButton.hidden = false
        buttonFrame.hidden = false
    }
    
    @IBAction func mClicked(sender: AnyObject) {
        
        currentVar = "m"
        if (currentM == 0) {
            
            sliderM.setValue(0, animated: false)
        }
        else {
            sliderM.setValue(Float(currentM), animated: false)
        }
        sliderM.hidden = false
        enterButton.hidden = false
        buttonFrame.hidden = false
    }
    
    @IBAction func nClicked(sender: AnyObject) {
        
        currentVar = "n"
        if (currentN == 0) {
            
            sliderM.setValue(0, animated: false)
        }
        else {
            sliderM.setValue(Float(currentN), animated: false)
        }
        sliderM.hidden = false
        enterButton.hidden = false
        buttonFrame.hidden = false
    }
    
    //all slider changes are redirected to here
    //all formatting for the label is done in here
    func valChanged() {
        
        //the current K, J, M, N values - doesn't change
        switch (currentVar) {
            
        case "k":
            currentK = Int(sliderM.value)
            break;
         
        case "j":
            currentJ = Int(sliderM.value)
            break;
            
        case "m":
            currentM = Int(sliderM.value)
            break;
            
        case "n":
            currentN = Int(sliderM.value)
            break;
            
        default:
            break;
        
        }
        
        //a temporary K value for formatting
        var tempCurrentK = String(currentK)
      
        if (currentK == 1) {
            
            tempCurrentK = "("
        }
        else if (currentK == -1) {
            
            tempCurrentK = "(-"
        }
        else {
            
            tempCurrentK = "(\(currentK)"
        }
        
        //a temporary J value for formatting
        var tempCurrentJ = String(currentJ)
        
        if (currentJ == 1) {
            
            tempCurrentJ = "("
        }
        else if (currentJ == -1) {
            
            tempCurrentJ = "(-"
        }
        else {
            
            tempCurrentJ = "(\(currentJ)"
        }
        
        //a temporary M value to be used for formatting
        var tempCurrentM = String(currentM)
        
        if (currentM < 0) {
            
            tempCurrentM = "x + \(abs(currentM)))" //(x + m)
        }
        else if (currentM > 0) {
            
            tempCurrentM = "x - \(currentM))"      //(x - m)
        }
        else {
            
            tempCurrentM = "x"                      //x
        }
        
        //a temporary N value to be used for formatting
        var tempCurrentN = String(currentN)
        
        if (currentN < 0) {
            
            tempCurrentN = "x + \(abs(currentN)))"
        }
        else if (currentN > 0) {
            
            tempCurrentN = "x - \(currentN))"
        }
        else {
            
            tempCurrentN = "x"
        }
        
        if (currentK == 0 && currentJ == 0 && currentM == 0 && currentN == 0) {
            answerLabel.text = "x²" //x² is when both factors are 0
            
            if (fromPause == true) {
                
                //if view loaded from pause, AND both sliders are 0, reset the label
                answerLabel.text = "( kx - m ) ( jx - n )"
            }
        }
        else {
            
            //finally, use the formatted variables to make the answerLabel
            answerLabel.text = ("\(tempCurrentK)\(tempCurrentM) \(tempCurrentJ)\(tempCurrentN)")
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
        buttonFrame.hidden = true
        rightOrWrong.hidden = true
        pauseButton.hidden = false
        pauseImage.hidden = false
        sliderM.hidden = true
        currentJ = 1
        currentK = 1
        currentM = 0
        currentN = 0
    }
    
    //check user's answer with the correct answer
    func checkAnswer(){
        
        //two cases of correct answer
        //this is because there are two ways to input a correct answer
        //ex: (2x-3)(3x+5) is same as (3x+5)(2x-3)
        if (Int(firstFactor) == (currentM) && Int(secondFactor) == (currentN) && kValue == currentK && jValue == currentJ) {
            
            ttlScore++
            rightOrWrong.image = UIImage(named: "Check Mark")
            
        } else if(Int(firstFactor) == (currentN) && Int(secondFactor) == (currentM) && kValue == currentJ && jValue == currentK) {
            
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
            pvc.kValue = kValue
            pvc.jValue = jValue
            pvc.question = question
            pvc.currentK = currentK
            pvc.currentJ = currentJ
            pvc.currentM = currentM
            pvc.currentN = currentN
            pvc.currentVar = currentVar

        }
        //if segue is linked to end, go to the End Screen
        else if(segue.identifier == "endUIF") {
            
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "User Input Factor"
        }
    }

}
