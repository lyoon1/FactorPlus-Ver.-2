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
    
    
    @IBOutlet weak var graphView: LineChartView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressUIG: UIProgressView!
    @IBOutlet weak var enterButton: UIButton!
    
    var numQuestions = Int(), ttlScore = Int()
    
    @IBAction func changeProgress(sender: AnyObject) {
        numQuestions++
        var temp = Double(numQuestions)/10
        progressUIG.setProgress(Float(temp), animated: true)
        endGame()
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
        graphView.zoom(1.2, scaleY: 1, x: 110, y: 82)
    }
    
    
    @IBAction func pauseClicked(sender: AnyObject) {
        performSegueWithIdentifier("pauseUIG", sender: sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var temp = Double(numQuestions)/10
        progressUIG.setProgress(Float(temp), animated: false)
        var graphPoint = GraphingPoints()
        
        let xval = graphPoint.getXVal()
        let yval = graphPoint.getYVal()
        setChart(xval, yval:yval)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func endGame() {
        if(numQuestions == 10)
        {
            performSegueWithIdentifier("endUIG", sender: self)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "pauseUIG")
        {
            let pvc = segue.destinationViewController as! PauseViewController
            pvc.numQuestion = numQuestions
            pvc.score = ttlScore
            pvc.type = "User Input Graph"
        }
        else if(segue.identifier == "endUIG")
        {
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "User Input Graph"
        }
    }

}
