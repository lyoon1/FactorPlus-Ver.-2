//
//  MainViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-10-26.
//  Copyright © 2015 LYM. All rights reserved.
//
//MainViewController class is the first view controller that is shown when the app opens
//The main function of this class is to enable the user to navigate to different options by the items (cells) in the collectionView object
//To do so, functions that initilize, specialize (give a specific image to each item (cell), cause a specific action to take place when the item (cell) is clicked), and give functionality to the item (cell) objects
//Some additional functions for esthetics are coded along with the decloration of the cells in the collectionView, which are implemented for a better appeal to the user
//To do so, UIScrollView is delegated into MainViewController
//This allows for fixing the items in the collectionView according to the scroll index, moving to the middle item when the view controller loads, as well as the access to the scroll position of the collectionView
//
//Source 1: https://www.youtube.com/watch?v=_d-xZv0JrRE UIScrollViewController
//Source 2: https://www.youtube.com/watch?v=JbPc62YWhPQ UICollectionView, pushing to the next view controller using identifiers

import UIKit
//To implement all the functionalities needed to initialize, change, and scroll through the collectionView, MainViewController has to be called as a subclass of UICollectionViewDelegatem UICollectionViewDataSource, and UIScrollViewDelegate

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    //initialization of UICollectionView object in MainViewController from the Storyboard
    @IBOutlet weak var collectionView: UICollectionView!
   
   //initialization of UISlider object in MainViewController from the Storyboard
    @IBOutlet weak var mainSlider: UISlider!
   
   //declaration and initialization of the array of images that will be displayed in the collectionView  object
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
        
        //The identifiers called in this method must be present in the storyboard
        //The identifiers are placed on the segue objects that link up two view controllers
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
    //Function that takes the identifier from the function above, and proceed the program to the next view controller according to the identifier
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "Start")
        {
            //The segue with identifier "Start" connects MainViewController to StartViewController
            //The following line of code pushes the screen from the MainViewContoller to the StartViewController as the StartViewController is declared and initialized as the destinationViewContoller
            let svc = segue.destinationViewController as! StartViewController
        }
        else if(segue.identifier == "Help")
        {
            //Same concept as above
            let hvc = segue.destinationViewController as! HelpViewController
        }
        else if(segue.identifier == "Credits")
        {
            //Same concept as above
            let cvc = segue.destinationViewController as! CreditsViewController
        }
    }
    //Function that will fix the collectionView view to a specific spot when the user interaction ends
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //A collectionView can be somewhat customized in the storyboard
        //The specified customizations can be accessed in the form of a UICollectionViewFlowLayout, if FlowLayout option is selected
        //Through the UICollectionViewFlowLayout, the system can determine the direction of the scrolling, constraints on the cells, etc.
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        
        //The line of code below gives the length of the item (cell) plus its spacing
        let cellLengthPlusSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        //targetContentOffset.memory returns the offset from the left of the collectionView to the middle of the displayed collectionView at the moment the user stops his/her interaction with the collectionView 
        var offset = targetContentOffset.memory
        
        //The line of code below is used to find the approximate index of the item being displayed in the collectionView
        //Offset is added to scrollView.contentInset.Left, since the offset begins from the first item without considering the inset before the item
        //This is a problem, since cellLengthPlusSpacing has the length of the item (cell) plus minimumLineSpacing, and therefore the inset is already a part of the value (this is because the inset value was set to be the same as the minimumLineSpacing value in the Storyboard)
        let index = (offset.x + scrollView.contentInset.left) / cellLengthPlusSpacing
        
        //The line of code below allows for the program to calculate which item should the view of the collectionView be fixed to when the user interaction ends
        let roundedIndex = round(index)
        
        //A new offset is created as a CGPoint that will have the coordinates required to fix the view of the collectionView to an item so that the item will be centered in the colllectionView
        offset = CGPoint(x: (roundedIndex * cellLengthPlusSpacing - scrollView.contentInset.left), y: -scrollView.contentInset.top)
        
        //targetContentOffset.memory can be both accessed and mutated, and therefore simply setting the new offset as the targetContentOffset.memory changes the view according to the offset
        targetContentOffset.memory = offset
    }
    //Function that will find the percentage of the collectionView that is scrolled whenever the collectionView is scrolled by a user
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //The maximum contentOffset horizontally is 520.0
        //By dividing the current contentOffset by 520.0, the percentage of collectionView scrolled can be found
        var percentOffset = Float(scrollView.contentOffset.x)/520.0
        
        //Using the percentOffset, mainSlider can adjust to a specific position
        //To make the movement look smooth, the boolean for animated is set to true
        //Using this line of code, an indicator for the scrollView can be displayed to the user
        mainSlider.setValue(percentOffset, animated: true)
    }
}

