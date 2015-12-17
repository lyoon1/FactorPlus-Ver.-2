//
//  MultipleChoice2ViewController.swift
//  Factor+
//
//  Created by Jia Long Ma on 2015-11-03.
//  Copyright © 2015 LYM. All rights reserved.
//
//Credits to:
//Taehyun Lee: For integration into the UI and separating the algorithmn into functions
//Leo Yoon: For integration of the buttons around the algorithm and implementing the pause function
//Jia Long Ma: For creating the base algorithm that generates multiple choice answers and returns the correct index

import UIKit
import Charts

class MultipleChoice2ViewController: UIViewController {
    
    
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    @IBOutlet weak var choice3Button: UIButton!
    @IBOutlet weak var choice4Button: UIButton!
    @IBOutlet weak var progressMCG: UIProgressView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var coverUpButton: UIButton!
    @IBOutlet weak var graphView: LineChartView!
    @IBOutlet weak var graphView2: LineChartView!
    @IBOutlet weak var pauseImage: UIImageView!
    
    var rightAnsIndex = Int(), numQuestions = Int(), ttlScore = Int()
    var fromPause: Bool = false
    var MultipleChoice = MultipleCGraph()
    var choice = [String]()
    var xValues = [String]()
    var yValues = [Double]()
    
    @IBAction func choice1Clicked(sender: AnyObject) {
    
        if (checkForRightAnswer(1) == true)
        {
            choice1Button.backgroundColor = UIColor.greenColor()     //if correct, set the button to green
            ttlScore++
        }
        else //if choice 1 is incorrect
        {
            choice1Button.backgroundColor = UIColor.redColor()       //if incorrect, set the button to red
            
            //then check every other index to see if they are correct, and highlight the correct answer in green
            if (checkForRightAnswer(2) == true) {
                choice2Button.backgroundColor = UIColor.greenColor()
            }
                
            else if (checkForRightAnswer(3) == true) {
                choice3Button.backgroundColor = UIColor.greenColor()
            }
                
            else if (checkForRightAnswer(4) == true) {
                choice4Button.backgroundColor = UIColor.greenColor()
            }
        }
        
        nextButton.hidden = false       //show the 'next' button
        pauseButton.hidden = true       //hide the 'pause' button to prevent the question from resetting
        coverUpButton.hidden = false    //show the 'coverUp' button which is to prevent other answer buttons from
        //being clicked once the question is answered
        pauseImage.hidden = true        //hide the pause image as well

    }
    @IBAction func choice2Clicked(sender: AnyObject) {
        if (checkForRightAnswer(2) == true)
        {
            choice2Button.backgroundColor = UIColor.greenColor()
            ttlScore++
        }
        else
        {
            choice2Button.backgroundColor = UIColor.redColor()
            
            if (checkForRightAnswer(1) == true) {
                choice1Button.backgroundColor = UIColor.greenColor()
            }
                
            else if (checkForRightAnswer(3) == true) {
                choice3Button.backgroundColor = UIColor.greenColor()
            }
                
            else if (checkForRightAnswer(4) == true) {
                choice4Button.backgroundColor = UIColor.greenColor()
            }
        }
        
        nextButton.hidden = false
        pauseButton.hidden = true
        coverUpButton.hidden = false
        pauseImage.hidden = true
    }
    @IBAction func choice3Clicked(sender: AnyObject) {
        if (checkForRightAnswer(3) == true)
        {
            choice3Button.backgroundColor = UIColor.greenColor()
            ttlScore++
        }
        else
        {
            choice3Button.backgroundColor = UIColor.redColor()
            
            if (checkForRightAnswer(1) == true) {
                choice1Button.backgroundColor = UIColor.greenColor()
            }
                
            else if (checkForRightAnswer(2) == true) {
                choice2Button.backgroundColor = UIColor.greenColor()
            }
                
            else if (checkForRightAnswer(4) == true) {
                choice4Button.backgroundColor = UIColor.greenColor()
            }
        }
        
        nextButton.hidden = false
        pauseButton.hidden = true
        coverUpButton.hidden = false
        pauseImage.hidden = true
    }
    @IBAction func choice4Clicked(sender: AnyObject) {
        if (checkForRightAnswer(4) == true)
        {
            choice4Button.backgroundColor = UIColor.greenColor()
            ttlScore++
        }
        else
        {
            choice4Button.backgroundColor = UIColor.redColor()
            
            if (checkForRightAnswer(1) == true) {
                choice1Button.backgroundColor = UIColor.greenColor()
            }
                
            else if (checkForRightAnswer(2) == true) {
                choice2Button.backgroundColor = UIColor.greenColor()
            }
                
            else if (checkForRightAnswer(3) == true) {
                choice3Button.backgroundColor = UIColor.greenColor()
            }
        }
        
        nextButton.hidden = false
        pauseButton.hidden = true
        coverUpButton.hidden = false
        pauseImage.hidden = true
    }
    @IBAction func pauseClicked(sender: AnyObject) {
        performSegueWithIdentifier("pauseMCG", sender: sender)
    }

    @IBAction func nextButtonClicked(sender: AnyObject) {
        
        resetColours()
        changeProgress()
        makeMultipleChoice()
        pauseButton.hidden = false
        nextButton.hidden = true
        coverUpButton.hidden = true
        pauseImage.hidden = false

    }
    
    func changeProgress(){
        numQuestions++
        var temp = Double(numQuestions)/10
        progressMCG.setProgress(Float(temp), animated: true)
        
        MultipleChoice = MultipleCGraph()
        
        var choice = MultipleChoice.getChoice
        
        endGame()
    }
    
    func resetColours(){
        choice1Button.backgroundColor = UIColor(red: 222/255.0, green: 168/255.0, blue: 160/255.0, alpha: 1.0)
        choice2Button.backgroundColor = UIColor(red: 205/255.0, green: 86/255.0, blue: 67/255.0, alpha: 1.0)
        choice3Button.backgroundColor = UIColor(red: 222/255.0, green: 168/255.0, blue: 160/255.0, alpha: 1.0)
        choice4Button.backgroundColor = UIColor(red: 205/255.0, green: 86/255.0, blue: 67/255.0, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var temp = Double(numQuestions)/10
        progressMCG.setProgress(Float(temp), animated: false)
        coverUpButton.hidden = true
        
        graphView.zoom(1.2, scaleY: 1, x: 120, y: 64)
        graphView.dragEnabled = false
        graphView.doubleTapToZoomEnabled = false
        
        graphView2.zoom(1.2, scaleY: 1, x: 120, y: 64)
        graphView2.dragEnabled = false
        graphView2.doubleTapToZoomEnabled = false
        
        if (fromPause == true) {
            setChart(xValues, yval: yValues)
            choice1Button.setTitle(choice[0], forState: .Normal)
            choice2Button.setTitle(choice[1], forState: .Normal)
            choice3Button.setTitle(choice[2], forState: .Normal)
            choice4Button.setTitle(choice[3], forState: .Normal)
        }
        else {
            var graphPoint = MultipleCGraph.getGraphOfPointsMC(MultipleChoice)
        
            let xval = graphPoint().getXVal()
            let yval = graphPoint().getYVal()
            setChart(xval, yval:yval)
            makeMultipleChoice()
        }
        // Do any additional setup after loading the view.
    }

    //http://www.appcoda.com/ios-charts-api-tutorial/
    func setChart(xval:[String], yval:[Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<xval.count {
            let dataEntry = ChartDataEntry(value: yval[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let xvalDataSet = LineChartDataSet(yVals: dataEntries, label: "")
        let xvalData = LineChartData(xVals: xval, dataSet: xvalDataSet)
        graphView.data = xvalData
        graphView.data?.setValueFont(UIFont(name:"Helvetica Neuve", size: 12))
        graphView.setDescriptionTextPosition(x: CGFloat(10000), y: CGFloat(100000))
     
        graphView2.data = xvalData
        graphView2.data?.setValueFont(UIFont(name:"Helvetica Neuve", size: 12))
        graphView2.setDescriptionTextPosition(x: CGFloat(10000), y: CGFloat(100000))
        
        for (var i = 0; i < 12; i++)
        {
            xValues.insert(xval[i], atIndex: i)
            yValues.insert(yval[i], atIndex: i)
        }
        
    }

    func makeMultipleChoice() {
      //  var valueGenerator = GraphingPoints()
        
        rightAnsIndex = MultipleChoice.getRightIndex()
        choice = MultipleChoice.getChoice()
        
        self.choice1Button.setTitle(choice[0], forState: .Normal)
        self.choice2Button.setTitle(choice[1], forState: .Normal)
        self.choice3Button.setTitle(choice[2], forState: .Normal)
        self.choice4Button.setTitle(choice[3], forState: .Normal)
    }
    
    func checkForRightAnswer(buttonNumber: Int) -> Bool
    {
        if (rightAnsIndex == (buttonNumber - 1))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func endGame() {
        if(numQuestions == 10)
        {
            performSegueWithIdentifier("endMCG", sender: self)
        }
        else
        {
            var graphPoint = MultipleCGraph.getGraphOfPointsMC(MultipleChoice)
            
            let xval = graphPoint().getXVal()
            let yval = graphPoint().getYVal()
            setChart(xval, yval: yval)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "pauseMCG")
        {
            let pvc = segue.destinationViewController as! PauseViewController
            pvc.score = ttlScore
            pvc.numQuestion = numQuestions
            pvc.type = "Multiple Choice Graph"
            pvc.rightAnswerIndex = rightAnsIndex
            
            for (var i = 0; i <= 3; i++) {
                pvc.multipleChoiceChoices.insert(choice[i], atIndex: i)
            }
            
            for (var i = 0; i < 12; i++) {
                pvc.xval.insert(xValues[i], atIndex: i)
                pvc.yval.insert(yValues[i], atIndex: i)
            }
        }
        else if(segue.identifier == "endMCG")
        {
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "Multiple Choice Graph"
        }
    }

}
