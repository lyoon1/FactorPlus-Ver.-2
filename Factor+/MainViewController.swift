//
//  MainViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-10-26.
//  Copyright © 2015 LYM. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    @IBOutlet weak var mainSlider: UISlider!
   
    let imageArray = [UIImage(named:"Help"),UIImage(named:"Start"),UIImage(named:"Credits")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImage = UIImage(named: "Thumb Image for Main Menu")
        
        mainSlider.setThumbImage(thumbImage, forState: UIControlState.Normal)
        mainSlider.setThumbImage(thumbImage, forState: UIControlState.Highlighted)
        mainSlider.userInteractionEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        let indexPath = NSIndexPath(forItem: 1, inSection: 0)
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Options Cell", forIndexPath: indexPath) as! OptionsCollectionViewCell
        
        cell.featuredImage?.image = imageArray[indexPath.item]
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.item == 0)
        {
            self.performSegueWithIdentifier("Help", sender: self)
        }
        else if(indexPath.item == 1)
        {
            self.performSegueWithIdentifier("Start", sender: self)
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
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        
        let cellLengthPlusSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.memory
        
        let index = (offset.x + scrollView.contentInset.left) / cellLengthPlusSpacing
        
        let roundedIndex = round(index)
        
        offset = CGPoint(x: (roundedIndex * cellLengthPlusSpacing - scrollView.contentInset.left) - 10, y: -scrollView.contentInset.top)
        targetContentOffset.memory = offset
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var percentOffset = Float(scrollView.contentOffset.x)/500.0
        
        mainSlider.setValue(percentOffset, animated: true)
    }
}

