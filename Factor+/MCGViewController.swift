//
//  MultipleChoice2ViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-03.
//  Copyright © 2015 LYM. All rights reserved.
//

import UIKit

class MultipleChoice2ViewController: UIViewController {
    
    
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    @IBOutlet weak var choice3Button: UIButton!
    @IBOutlet weak var choice4Button: UIButton!
    @IBOutlet weak var progressMCG: UIProgressView!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBAction func choice1Clicked(sender: AnyObject) {
    
        changeProgress()
    }
    @IBAction func choice2Clicked(sender: AnyObject) {
    
        changeProgress()
    }
    @IBAction func choice3Clicked(sender: AnyObject) {
    
        changeProgress()
    }
    @IBAction func choice4Clicked(sender: AnyObject) {
    
        changeProgress()
    }
    @IBAction func pauseClicked(sender: AnyObject) {
        performSegueWithIdentifier("pauseMCG", sender: sender)
    }
    
    var numQuestions = Int(), ttlScore = Int()
    
    
    func changeProgress(){
        numQuestions++
        var temp = Double(numQuestions)/10
        progressMCG.setProgress(Float(temp), animated: true)
        endGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var temp = Double(numQuestions)/10
        progressMCG.setProgress(Float(temp), animated: false)
        // Do any additional setup after loading the view.
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
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "pauseMCG")
        {
            let pvc = segue.destinationViewController as! PauseViewController
            pvc.score = ttlScore
            pvc.numQuestion = numQuestions
            pvc.type = "Multiple Choice Graph"
        }
        else if(segue.identifier == "endMCG")
        {
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "Multiple Choice Graph"
        }
    }

}
