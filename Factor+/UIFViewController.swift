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
    @IBOutlet weak var sliderS: UISlider!
    @IBOutlet weak var sliderZ: UISlider!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var progressUIF: UIProgressView!
    @IBOutlet weak var pauseButton: UIButton!
    
    var ttlScore = Int(), numQuestions = Int()
    
    @IBAction func pauseClicked(sender: AnyObject) {
        performSegueWithIdentifier("pauseUIF", sender: sender)
    }
    @IBOutlet weak var label: UILabel!
    
    //declaring and initializing a function of the sliders within the view controller.
    //source to the code: https://www.youtube.com/watch?v=jJA9UCbcos0
    
    @IBAction func changeProgress(sender: AnyObject) {
        numQuestions += 1
        var temp = Double(numQuestions)/10
        progressUIF.setProgress(Float(temp), animated: true)
        endGame()
    }
    @IBAction func valChangeS(sender: UISlider) {
        
        var currentS = Int(sliderS.value)
        var currentZ = Int(sliderZ.value)
        
        if(currentS >= 0 && currentZ >= 0){
            label.text = "( x - \(currentS) ) ( x - \(currentZ) )"
        }
        else if(currentS >= 0 && currentZ < 0)
        {
            var temp = abs(currentZ)
            label.text = "( x - \(currentS) ) ( x + \(temp) )"
        }
        else if(currentS < 0 && currentZ >= 0)
        {
            var temp = abs(currentS)
            label.text = "( x + \(temp) ) ( x - \(currentZ) )"
        }
        else
        {
            var temp = abs(currentS), temp2 = abs(currentZ)
            label.text = "( x + \(temp) ) ( x + \(temp2) )"
        }
        
        
    }
    @IBAction func valChangeZ(sender: UISlider) {
        
        var currentS = Int(sliderS.value)
        var currentZ = Int(sliderZ.value)
        
        if(currentS >= 0 && currentZ >= 0){
            label.text = "( x - \(currentS) ) ( x - \(currentZ) )"
        }
        else if(currentS >= 0 && currentZ < 0)
        {
            var temp = abs(currentZ)
            label.text = "( x - \(currentS) ) ( x + \(temp) )"
        }
        else if(currentS < 0 && currentZ >= 0)
        {
            var temp = abs(currentS)
            label.text = "( x + \(temp) ) ( x - \(currentZ) )"
        }
        else
        {
            var temp = abs(currentS), temp2 = abs(currentZ)
            label.text = "( x + \(temp) ) ( x + \(temp2) )"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(numQuestions)
        var temp = Double(numQuestions)/10
        progressUIF.setProgress(Float(temp), animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        }
        else if(segue.identifier == "endUIF")
        {
            let evc = segue.destinationViewController as! EndViewController
            evc.numCorrect = ttlScore
            evc.type = "User Input Factor"
        }
    }
    

   

}
