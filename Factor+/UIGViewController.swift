//
//  UIGViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-04.
//  Copyright © 2015 LYM. All rights reserved.
//

import UIKit
import Charts

class UIGViewController: UIViewController {
        
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
    
    var numQuestions = Int(), ttlScore = Int(), currentA = Int(), currentH = Int(), currentK = Int()
    var fromPause: Bool = false
    var graphPoint = [GraphingPoints]()
    var xValues = [String]()
    var yValues = [Double]()
    
    func makeNewGraph() {
        
        graphPoint.insert(GraphingPoints(), atIndex: 0)
    }

    @IBAction func changeProgress(sender: AnyObject) {
        checkAnswer()
        nextButton.hidden = false
        enterButton.hidden = true
        pauseButton.hidden = true
        pauseImage.hidden = true
        rotateLabel.hidden = true
    }
    
    @IBAction func valChangeA(sender: AnyObject) {
        
        currentA = Int(sliderA.value)
        currentH = Int(sliderH.value)
        currentK = Int(sliderK.value)
        
        var tempCurrentA = String(currentA)
        if (currentA == 0) {
            tempCurrentA = "a"
        }
        else if (currentA == 1) {
            tempCurrentA = ""
        }
        else if (currentA == -1) {
            tempCurrentA = "-"
        }
        
        var tempCurrentH = String()
        
        if (currentH < 0) {
            tempCurrentH = " + \(abs(currentH))"
        }
        else if (currentH > 0) {
            tempCurrentH = " - \(currentH)"
        }
        else {
            tempCurrentH = ""
        }
        
        var tempCurrentK = String()
        
        if (currentK < 0) {
            tempCurrentK = " - \(abs(currentK))"
        }
        else if (currentK > 0) {
            tempCurrentK = " + \(currentK)"
        }
        else {
            tempCurrentK = ""
        }
        
        answerLabel.text = ("\(tempCurrentA)(x\(tempCurrentH))²\(tempCurrentK)")
        
        if (fromPause == true && currentA == 0 && currentH == 0 && currentK == 0) {
            
            answerLabel.text = "a(x - h)² + k"
        }
    }
    
    @IBAction func valChangeH(sender: AnyObject) {
        currentA = Int(sliderA.value)
        currentH = Int(sliderH.value)
        currentK = Int(sliderK.value)
        
        var tempCurrentA = String(currentA)
        if (currentA == 0) {
            tempCurrentA = "a"
        }
        else if (currentA == 1) {
            tempCurrentA = ""
        }
        else if (currentA == -1) {
            tempCurrentA = "-"
        }
        
        var tempCurrentH = String()
        
        if (currentH < 0) {
            tempCurrentH = " + \(abs(currentH))"
        }
        else if (currentH > 0) {
            tempCurrentH = " - \(currentH)"
        }
        else {
            tempCurrentH = ""
        }
        
        var tempCurrentK = String()
        
        if (currentK < 0) {
            tempCurrentK = " - \(abs(currentK))"
        }
        else if (currentK > 0) {
            tempCurrentK = " + \(currentK)"
        }
        else {
            tempCurrentK = ""
        }
        
        answerLabel.text = ("\(tempCurrentA)(x\(tempCurrentH))²\(tempCurrentK)")
        
    }
    
    @IBAction func valChangeK(sender: AnyObject) {
        currentA = Int(sliderA.value)
        currentH = Int(sliderH.value)
        currentK = Int(sliderK.value)
        
        var tempCurrentA = String(currentA)
        if (currentA == 0) {
            tempCurrentA = "a"
        }
        else if (currentA == 1) {
            tempCurrentA = ""
        }
        else if (currentA == -1) {
            tempCurrentA = "-"
        }
        
        var tempCurrentH = String()
        
        if (currentH < 0) {
            tempCurrentH = " + \(abs(currentH))"
        }
        else if (currentH > 0) {
            tempCurrentH = " - \(currentH)"
        }
        else {
            tempCurrentH = ""
        }
        
        var tempCurrentK = String()
        
        if (currentK < 0) {
            tempCurrentK = " - \(abs(currentK))"
        }
        else if (currentK > 0) {
            tempCurrentK = " + \(currentK)"
        }
        else {
            tempCurrentK = ""
        }
        
        answerLabel.text = ("\(tempCurrentA)(x\(tempCurrentH))²\(tempCurrentK)")
        
    }
    
    //http://www.appcoda.com/ios-charts-api-tutorial/
    func setChart(xval: [String], yval: [Double]) {
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
    
    @IBAction func nextButtonClicked(sender: AnyObject) {
        numQuestions++
        var temp = Double(numQuestions)/10
        progressUIG.setProgress(Float(temp), animated: true)
        endGame()
        makeNewGraph()
        plotGraph()
        nextButton.hidden = true
        rightOrWrong.hidden = true
        enterButton.hidden = false
        pauseButton.hidden = false
        pauseImage.hidden = false
        rotateLabel.hidden = false
        
    }
    
    @IBAction func pauseClicked(sender: AnyObject) {
        performSegueWithIdentifier("pauseUIG", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var temp = Double(numQuestions)/10
        progressUIG.setProgress(Float(temp), animated: false)
    
        graphView.zoom(1.2, scaleY: 1, x: 120, y: 64)
        graphView.dragEnabled = false
        graphView.doubleTapToZoomEnabled = false
        
        graphView2.zoom(1.2, scaleY: 1, x: 120, y: 64)
        graphView2.dragEnabled = false
        graphView2.doubleTapToZoomEnabled = false
        
        if (fromPause == true) {
            setChart(xValues, yval: yValues)
            
            sliderA.setValue(Float (currentA), animated: false)
            sliderH.setValue(Float (currentH), animated: false)
            sliderK.setValue(Float (currentK), animated: false)
            valChangeA(sliderA)
        
        }
        else {
            makeNewGraph()
            plotGraph()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func plotGraph() {
        sliderA.setValue(Float (0), animated: false)
        sliderH.setValue(Float (0), animated: false)
        sliderK.setValue(Float (0), animated: false)
        
        answerLabel.text = "a(x - h)² + k"
        
        if (numQuestions < 10)
        {
            let xval = graphPoint[0].getXVal()
            let yval = graphPoint[0].getYVal()
            setChart(xval, yval:yval)
        }
    }
    
    func endGame() {
        if(numQuestions == 10) {
            performSegueWithIdentifier("endUIG", sender: self)
        }
    }
    
    func checkAnswer() {
        var tempCorrectA = graphPoint[0].getaVal()
        var tempCorrectH = graphPoint[0].gethVal()
        var tempCorrectK = graphPoint[0].getkVal()
        
        if (Int(tempCorrectA) == (Int(sliderA.value)) && Int(tempCorrectH) == (Int(sliderH.value)) && Int(tempCorrectK) == (Int(sliderK.value))) {
    
            ttlScore++
            rightOrWrong.image = UIImage(named: "Check Mark")
        }
        else {
            rightOrWrong.image = UIImage(named: "X Mark")
        }
        
        rightOrWrong.hidden = false;
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "pauseUIG")
        {
            let pvc = segue.destinationViewController as! PauseViewController
            pvc.numQuestion = numQuestions
            pvc.score = ttlScore
            pvc.type = "User Input Graph"
            pvc.currentA = Int(sliderA.value)
            pvc.currentH = Int(sliderH.value)
            pvc.currentK = Int(sliderK.value)

            for (var i = 0; i < 12; i++) {
                pvc.xval.insert(xValues[i], atIndex: i)
                pvc.yval.insert(yValues[i], atIndex: i)
            }
            
            pvc.graphPoint.insert(graphPoint[0], atIndex: 0)
        }
        else if(segue.identifier == "endUIG")
        {
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "User Input Graph"
        }
    }

}
