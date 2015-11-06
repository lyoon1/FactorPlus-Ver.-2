//
//  EndViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-05.
//  Copyright © 2015 LYM. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {
    
    
    var numCorrect = Int(), type = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let mvc = segue.destinationViewController as! MainViewController
        
    }

}
