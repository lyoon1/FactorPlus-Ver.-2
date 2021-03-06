//
//  UIRViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-04.
//  Copyright © 2015 LYM. All rights reserved.
//

import UIKit

class UIRViewController: UIViewController {

    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var progressUIR: UIProgressView!
    @IBAction func pauseClicked(sender: AnyObject) {
        performSegueWithIdentifier("pauseUIR", sender: sender)
    }
    @IBAction func changeProgress(sender: AnyObject) {
        numQuestions++
        var temp = Double(numQuestions)/10
        progressUIR.setProgress(Float(temp), animated: true)
        endGame()
    }
    
    
    var ttlScore = Int(), numQuestions = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var temp = Double(numQuestions)/10
        progressUIR.setProgress(Float(temp), animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func endGame() {
        if(numQuestions == 10)
        {
            performSegueWithIdentifier("endUIR", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "pauseUIR")
        {
            let pvc = segue.destinationViewController as! PauseViewController
            pvc.numQuestion = numQuestions
            pvc.score = ttlScore
            pvc.type = "User Input Right Triangle"
        }
        else if(segue.identifier == "endUIR")
        {
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "User Input Right Triangle"
        }
    }

}
