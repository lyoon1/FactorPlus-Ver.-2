//
//  UIFViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-10-27.
//  Copyright © 2015 LYM. All rights reserved.
//

import UIKit

class UIFViewController: UIViewController {
    
    
    //initializing UI objects from the UIF (User Input Factor) view controller by declareing them as an outlet.
    @IBOutlet weak var sliderM: UISlider!
    @IBOutlet weak var sliderN: UISlider!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var progressUIF: UIProgressView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var rightOrWrong: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pauseImage: UIImageView!
    
    var ttlScore = Int(), numQuestions = Int(), currentM = Int(), currentN = Int()
    var firstFactor: String = ""
    var secondFactor: String = ""
    var fromPause: Bool = false
    var question: String = ""
    
    @IBAction func pauseClicked(sender: AnyObject) {
        performSegueWithIdentifier("pauseUIF", sender: sender)
    }
    @IBOutlet weak var label: UILabel!
    
    //declaring and initializing a function of the sliders within the view controller.
    //source to the code: https://www.youtube.com/watch?v=jJA9UCbcos0
    
    @IBAction func changeProgress(sender: AnyObject) {
        checkAnswer()
        nextButton.hidden = false
        enterButton.hidden = true
        pauseButton.hidden = true
        pauseImage.hidden = true
    }

    
    @IBAction func valChangeM(sender: AnyObject) {
        
        currentM = Int(sliderM.value)
        currentN = Int(sliderN.value)
        
        /*
        if(currentM >= 0 && currentN >= 0){
            label.text = "( x - \(currentM) ) ( x - \(currentN) )"
        }
        else if(currentM >= 0 && currentN < 0)
        {
            var temp = abs(currentN)
            label.text = "( x - \(currentM) ) ( x + \(temp) )"
        }
        else if(currentM < 0 && currentN >= 0)
        {
            var temp = abs(currentM)
            label.text = "( x + \(temp) ) ( x - \(currentN) )"
        }
        else
        {
            var temp = abs(currentM), temp2 = abs(currentN)
            label.text = "( x + \(temp) ) ( x + \(temp2) )"
        }
            */
        
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
        }
        else {
            label.text = ("\(tempCurrentM) \(tempCurrentN)")
        }
    }
    
    @IBAction func valChangeN(sender: AnyObject) {

        var currentM = Int(sliderM.value)
        var currentN = Int(sliderN.value)
        
        /*
        if(currentM >= 0 && currentN >= 0){
            label.text = "( x - \(currentM) ) ( x - \(currentN) )"
        }
        else if(currentM >= 0 && currentN < 0)
        {
            var temp = abs(currentN)
            label.text = "( x - \(currentM) ) ( x + \(temp) )"
        }
        else if(currentM < 0 && currentN >= 0)
        {
            var temp = abs(currentM)
            label.text = "( x + \(temp) ) ( x - \(currentN) )"
        }
        else
        {
            var temp = abs(currentM), temp2 = abs(currentN)
            label.text = "( x + \(temp) ) ( x + \(temp2) )"
        }
    */
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
        }
        else {
            label.text = ("\(tempCurrentM) \(tempCurrentN)")
        }

    }
    
    @IBAction func nextButtonClicked(sender: AnyObject) {
        numQuestions++
        var temp = Double(numQuestions)/10
        progressUIF.setProgress(Float(temp), animated: true)
        endGame()
        makeQuestion()
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
            
            if(currentM >= 0 && currentN >= 0){
                label.text = "( x - \(currentM) ) ( x - \(currentN) )"
            }
            else if(currentM >= 0 && currentN < 0)
            {
                var temp = abs(currentN)
                label.text = "( x - \(currentM) ) ( x + \(temp) )"
            }
            else if(currentM < 0 && currentN >= 0)
            {
                var temp = abs(currentM)
                label.text = "( x + \(temp) ) ( x - \(currentN) )"
            }
            else
            {
                var temp = abs(currentM), temp2 = abs(currentN)
                label.text = "( x + \(temp) ) ( x + \(temp2) )"
            }
        }
        else {
            makeQuestion()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeQuestion(){
        var quadraticRelation = quadratic(fromUI: true)
        
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
        if(numQuestions == 10)
        {
            performSegueWithIdentifier("endUIF", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "pauseUIF")
        {
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
        else if(segue.identifier == "endUIF")
        {
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "User Input Factor"
        }
    }

}
