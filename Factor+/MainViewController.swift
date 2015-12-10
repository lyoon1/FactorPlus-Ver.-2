//
//  MainViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-10-26.
//  Copyright © 2015 LYM. All rights reserved.
//

import UIKit
//To implement all the functionalities needed to initialize, change, and scroll through the collectionView, MainViewController has to be called as a subclass of UICollectionViewDelegatem UICollectionViewDataSource, and UIScrollViewDelegate

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    //initiliaztion of UICollectionView object in MainViewController from the Storyboard
    @IBOutlet weak var collectionView: UICollectionView!
   
   //initiliaztion of UISlider object in MainViewController from the Storyboard
    @IBOutlet weak var mainSlider: UISlider!
   
   //declaration and initiliazation of the array of images that will be displayed in the collectionView  object
    let imageArray = [UIImage(named:"Help"),UIImage(named:"Start"),UIImage(named:"Credits")]
    
    //Function that runs when the view of MainViewController loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Declaration and initialization of the thumbImage for mainSlider object
        let thumbImage = UIImage(named: "Thumb Image for Main Menu")
        
        //Implementation of the declared thumbImage into the mainSlider
        //Since the mainSlider object has different thumbImage for different state, the image has to be implemented twice for each instances
        mainSlider.setThumbImage(thumbImage, forState: UIControlState.Normal)
        mainSlider.setThumbImage(thumbImage, forState: UIControlState.Highlighted)
        //Disables the user interaction with the mainSlider object
        mainSlider.userInteractionEnabled = false
    }
    
    //Function that runs when the subViews (mainly the collectionView) fully loads
    override func viewDidLayoutSubviews() {
        
        //Declaration and initialization of NSIndexPath
        //NSIndexPath takes in two parameters, one signifying the item index, and the other the section index
        let indexPath = NSIndexPath(forItem: 1, inSection: 0)
        
        //When the subview loads, the collectionView will move to the 2nd item in the first section, which is the middle item (or the "Start" button)
        //The second item can be located with the indexPath declared earlier
        //This line of code must be called inside the viewDidLayoutSubviews method, as placing it anywhere else would cause the collectionView to center to the second item before it is initialized
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
    }
    
    //Function that returns number of sections in the collectionView
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Function that returns the number of items that will be displayed in the collectionView
    //In this case, it returns the number of items in the image array, since the images in the image arrays will be displayed in the items(cells) of the collection view object
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    //Function that declares and initializes all the cell objects that will be displayed in the collectionView, and returns them to the collectionView object
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //The cell is declared with the reusable identifier "Options Cell"
        //This allows for repeated decloration and initialization of the standard cell object specified in the storyboard
        //In the storyboard, the collection view in default has one cell that is displayed
        //This cell can be given assigned to a UICollectionViewCell class, which will allow for modification of contents inside the cell item
        //In the storyboard, the cell is given an identifier, so that when an array of cells are being initialized, the cells in the array would all have the property of the specific UICollectionViewCell
        //The cells declared below with identifier "Options Cell" will all have the properties of OptionsCollectionViewCell, essentially making them OptionsCollectionViewCell objects
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Options Cell", forIndexPath: indexPath) as! OptionsCollectionViewCell
        
        //OptionsCollectionView has an UIImageView object which is declared and initialized as an object that is a part of the standard cell with the identifier "Options Cell"
        //Below, the UIImageView object called featuredImage is accessed through the declared cell, and the image is set according to the desired index
        cell.featuredImage?.image = imageArray[indexPath.item]
        
        return cell
    }
    //Function that detects user interaction with a cell in specific index, and calls an identifier based on the index
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
        
        offset = CGPoint(x: (roundedIndex * cellLengthPlusSpacing - scrollView.contentInset.left), y: -scrollView.contentInset.top)
        targetContentOffset.memory = offset
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var percentOffset = Float(scrollView.contentOffset.x)/520.0
        
        mainSlider.setValue(percentOffset, animated: true)
    }
}

