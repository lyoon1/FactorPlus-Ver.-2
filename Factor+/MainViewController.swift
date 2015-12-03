//
//  MainViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-10-26.
//  Copyright © 2015 LYM. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    let imageArray = [UIImage(named:"Start"),UIImage(named:"Help"),UIImage(named:"Credits")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    private struct Storyboard {
        static let CellIdentifier = "Options Cell"
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! OptionsCollectionViewCell
        
        cell.featuredImage?.image = imageArray[indexPath.item]
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.item == 0)
        {
            self.performSegueWithIdentifier("Start", sender: self)
        }
        else if(indexPath.item == 1)
        {
            self.performSegueWithIdentifier("Help", sender: self)
        }
        else if(indexPath.item == 2)
        {
            self.performSegueWithIdentifier("Credits", sender: self)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "Start")
        {
            let svc = segue.destinationViewController as! StartViewController
        }
        else if(segue.identifier == "Help")
        {
            let hvc = segue.destinationViewController as! HelpViewController
        }
        else if(segue.identifier == "Credits")
        {
            let cvc = segue.destinationViewController as! CreditsViewController
        }
    }
}

