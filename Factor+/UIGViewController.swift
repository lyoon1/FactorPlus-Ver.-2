//
//  UIGViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-04.
//  Copyright © 2015 LYM. All rights reserved.
//
//  This class displays the User Input: Graph to Equation screen.
//  In this file, the application generates a random graph, and the user has to then
//  the quadratic class, and making an object of the class. Then the user needs to 
//  adjust the slider to create an equation that matches the graph.
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
import Charts

class UIGViewController: UIViewController {
    
    /*
    * sliderA: a(x - h)² + k
    * sliderH: the sliders control the variables
    * sliderK:
    * answerLabel: the label that displays the user's answer
    * rotateLabel: the label that gives instructions to rotate the screen
    * graphView: the graph displayed in portrait view
    * graphView2: the graph displayed in landscape view
    * pauseButton: the pause button
    * progressUIG: the progress bar
    * enterButton: the enter button to confirm the answer
    * nextButton: the next button to move onto the next question
    * rightOrWrong: displays Check Mark or X Mark
    * pauseImage: displays the pause symbol
    */
    @IBOutlet weak var sliderA: UISlider!
    @IBOutlet weak var sliderH: UISlider!
    @IBOutlet weak var sliderK: UISlider!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var rotateLabel: UILabel!
    @IBOutlet weak var graphView: LineChartView!
    @IBOutlet weak var graphView2: LineChartView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressUIG: UIProgressView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var rightOrWrong: UIImageView!
    @IBOutlet weak var pauseImage: UIImageView!
    
    /*
    * numQuestions: the number of questions answered
    * ttlScore: the number of questions correct
    * currentA: the current value of A
    * currentH: the current value of H
    * currentK: the current value of K
    * fromPause: has the view loaded from Pause Menu?
    * graphPoint: makes a graph using the graphingPoints class
    * xValues: Stores x values that will be inputed into a graphing function (x values must be strings)
    * yValues: Stores y values that will be inputed into a graphing function (y values must be doubles)
    */
    var numQuestions = Int(), ttlScore = Int(), currentA = Int(), currentH = Int(), currentK = Int()
    var fromPause: Bool = false
    var graphPoint = [GraphingPoints]()
    var xValues = [String]()
    var yValues = [Double]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var temp = Double(numQuestions)/10
        progressUIG.setProgress(Float(temp), animated: false)
        
        graphView.zoom(1.2, scaleY: 1, x: 120, y: 64) //zooms the graphView, which is a LineChartView by a certain percentage about the indicated point
        graphView.dragEnabled = false //disables user interaction with graphView via dragging
        graphView.doubleTapToZoomEnabled = false //disables user interaction with graphView via double tapping
        
        graphView2.zoom(1.2, scaleY: 1, x: 120, y: 64)
        graphView2.dragEnabled = false
        graphView2.doubleTapToZoomEnabled = false
        
        let yAxis = ChartLimitLine(limit: 0) //yAxis is declared as a ChartLimitLine object with its value set to 0
        let xAxis = ChartLimitLine(limit: 6.0) //xAxis is declared as a ChartLimitLine object with its x-index at 6
        //this actually creates the yAxis
        //It is declared as xAxis due to it being defined from the x-axis (x-index is the x value, and the value stored in the x-index is the y value)
        graphView.leftAxis.addLimitLine(yAxis) //adds a line through the y-axis
        graphView.xAxis.addLimitLine(xAxis) //adds a line through the x-axis
        graphView2.leftAxis.addLimitLine(yAxis)
        graphView2.xAxis.addLimitLine(xAxis)
        
        graphView.rightAxis.labelFont = UIFont(name: "", size: 0)! //lables on the right side of the graph is set to have a font of zero, making them invisible
        graphView2.rightAxis.labelFont = UIFont(name: "", size: 0)!
        
        if (fromPause == true) {
            
            setChart(xValues, yval: yValues) //when coming from PauseViewController with fromPause set to true, the x-values and y-values that were stored in the PauseViewController is set to be the xValues and yValues of this class
            //chart with x-value and y-value from pause screen is made
            
            sliderA.setValue(Float (currentA), animated: false)
            sliderH.setValue(Float (currentH), animated: false)
            sliderK.setValue(Float (currentK), animated: false)
            valChangeA(sliderA)
            
        }
        else {
            
            //otherwise make a new graph and plot it
            makeNewGraph()
            plotGraph()
        }
        
    }
    
    //generate a graph
    func makeNewGraph() {
        
        //this ensures that a new graph is made every time
        graphPoint.insert(GraphingPoints(), atIndex: 0)
    }
    
    //plotting the graph
    func plotGraph() {
        
        //set the sliders and answerLabel to default states
        sliderA.setValue(Float (0), animated: false)
        sliderH.setValue(Float (0), animated: false)
        sliderK.setValue(Float (0), animated: false)
        
        answerLabel.text = "a(x - h)² + k"
        
        //only make a new graph when the game is in progress
        if (numQuestions < 10)
        {
            let xval = graphPoint[0].getXVal()
            let yval = graphPoint[0].getYVal()
            setChart(xval, yval:yval)
        }
    }

    //runs when Enter is clicked
    @IBAction func changeProgress(sender: AnyObject) {
        
        //check for the answer, then show/hide appropriate buttons
        checkAnswer()
        nextButton.hidden = false
        enterButton.hidden = true
        pauseButton.hidden = true
        pauseImage.hidden = true
        rotateLabel.hidden = true
    }
    
    //if sliderA is touched
    @IBAction func valChangeA(sender: AnyObject) {
      
        valChanged()
    
        if (fromPause == true && currentA == 0 && currentH == 0 && currentK == 0) {
            
            answerLabel.text = "a(x - h)² + k"
        }
    }
    
    //if sliderH is touched
    @IBAction func valChangeH(sender: AnyObject) {
        
        valChanged()

    }
    
    //if sliderK is touched
    @IBAction func valChangeK(sender: AnyObject) {
       
        valChanged()
        
    }
    
    //all slider changes are redirected to here
    //all formatting for the label is done in here
    func valChanged() {
     
        currentA = Int(sliderA.value)
        currentH = Int(sliderH.value)
        currentK = Int(sliderK.value)
        
        //temporary variables used to format
        //no need to format A unless it's 0, 1, or -1
        //so initialize tempCurrentA right away
        var tempCurrentA = String(currentA)
        var tempCurrentH = String()
        var tempCurrentK = String()
        
        if (currentA == 0) {
            
            tempCurrentA = "a"
        }
        else if (currentA == 1) {
            
            tempCurrentA = ""
        }
        else if (currentA == -1) {
            
            tempCurrentA = "-"
        }
        
        if (currentH < 0) {
            
            tempCurrentH = " + \(abs(currentH))"
        }
        else if (currentH > 0) {
            
            tempCurrentH = " - \(currentH)"
        }
        else {
            
            tempCurrentH = ""
        }
        
        if (currentK < 0) {
            
            tempCurrentK = " - \(abs(currentK))"
        }
        else if (currentK > 0) {
            
            tempCurrentK = " + \(currentK)"
        }
        else {
            
            tempCurrentK = ""
        }
        
        //setting the answerLabel to correctly display the user's answer
        answerLabel.text = ("\(tempCurrentA)(x\(tempCurrentH))²\(tempCurrentK)")
        
    }
    
    //http://www.appcoda.com/ios-charts-api-tutorial/
    func setChart(xval: [String], yval: [Double]) { //this method plots the points on the LineChartViews
        var dataEntries: [ChartDataEntry] = [] //ChartDataEntry objects store the y-value for a specific index
        
        for i in 0..<xval.count { 
            
            let dataEntry = ChartDataEntry(value: yval[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let xvalDataSet = LineChartDataSet(yVals: dataEntries, label: "")//using the array of ChartDataEntry, LineChartDataSet object is created
        let xvalData = LineChartData(xVals: xval, dataSet: xvalDataSet)//by merging the x-values and y-values into one, LineChartData object is created
        graphView.data = xvalData //the LineChartData is set as the data of graphView
        graphView.data?.setValueFont(UIFont(name:"Helvetica Neuve", size: 12)) //this sets the font of the displayed y-values
        graphView.setDescriptionTextPosition(x: CGFloat(10000), y: CGFloat(100000))//this moves the description text label of the graph to be placed out of the graphView
        
        graphView2.data = xvalData
        graphView2.data?.setValueFont(UIFont(name:"Helvetica Neuve", size: 12))
        graphView2.setDescriptionTextPosition(x: CGFloat(10000), y: CGFloat(100000))
        
        for (var i = 0; i < 12; i++) //the x-values and y-values are set to attributes xValues and yValues so that the coordinates can be transferred between PauseViewController and UIGViewController
        {
            xValues.insert(xval[i], atIndex: i)
            yValues.insert(yval[i], atIndex: i)
        }
    }
    
    //when the Next Button is clicked
    @IBAction func nextButtonClicked(sender: AnyObject) {
        
        //update the game mode's progress
        numQuestions++
        var temp = Double(numQuestions)/10
        progressUIG.setProgress(Float(temp), animated: true)
        
        //check if game is done
        endGame()
        
        //make new graph
        makeNewGraph()
        plotGraph()
        
        //show/hide appropriate buttons
        nextButton.hidden = true
        rightOrWrong.hidden = true
        enterButton.hidden = false
        pauseButton.hidden = false
        pauseImage.hidden = false
        rotateLabel.hidden = false
        
    }
    
    //load the pause Segue if Pause Button is clicked
    @IBAction func pauseClicked(sender: AnyObject) {
        
        performSegueWithIdentifier("pauseUIG", sender: sender)
    }
    
    func endGame() {
        
        //load the end Segue if 10 questions have been answered
        if(numQuestions == 10) {
            
            performSegueWithIdentifier("endUIG", sender: self)
        }
    }
    
    func checkAnswer() {
        
        //get the correct answer values from the object
        var tempCorrectA = graphPoint[0].getaVal()
        var tempCorrectH = graphPoint[0].gethVal()
        var tempCorrectK = graphPoint[0].getkVal()
        
        //compare them to the sliders
        if (Int(tempCorrectA) == (Int(sliderA.value)) && Int(tempCorrectH) == (Int(sliderH.value)) && Int(tempCorrectK) == (Int(sliderK.value))) {
    
            //if correct,
            ttlScore++
            rightOrWrong.image = UIImage(named: "Check Mark")
        }
        else {
            
            //if incorrect
            rightOrWrong.image = UIImage(named: "X Mark")
        }
        
        //reveal the image: Check Mark or X Mark
        rightOrWrong.hidden = false;
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //Segue codes
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "pauseUIG") {

            //for pause, send in all necessary values,
            let pvc = segue.destinationViewController as! PauseViewController
            pvc.numQuestion = numQuestions
            pvc.score = ttlScore
            pvc.type = "User Input Graph"
            pvc.currentA = Int(sliderA.value)
            pvc.currentH = Int(sliderH.value)
            pvc.currentK = Int(sliderK.value)

            //including the x and y values of the graph
            for (var i = 0; i < 12; i++) {
                
                pvc.xval.insert(xValues[i], atIndex: i)
                pvc.yval.insert(yValues[i], atIndex: i)
            }
            
            //same object needs to be transferred back and forth
            pvc.graphPoint.insert(graphPoint[0], atIndex: 0)
        }
        else if(segue.identifier == "endUIG") {
            
            //for end, just send the total score & game mode type
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "User Input Graph"
        }
    }

}
