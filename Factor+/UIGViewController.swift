//
//  UIGViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-04.
//  Copyright © 2015 LYM. All rights reserved.
//

import UIKit

class UIGViewController: UIViewController {
    
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressUIG: UIProgressView!
    @IBOutlet weak var enterButton: UIButton!
    @IBAction func changeProgress(sender: AnyObject) {
        numQuestions++
        var temp = Double(numQuestions)/10
        progressUIG.setProgress(Float(temp), animated: true)
        endGame()
    }
    
    
    @IBAction func pauseClicked(sender: AnyObject) {
        performSegueWithIdentifier("pauseUIG", sender: sender)
    }
    
    var numQuestions = Int(), ttlScore = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var temp = Double(numQuestions)/10
        progressUIG.setProgress(Float(temp), animated: false)
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
