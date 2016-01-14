//
//  HelpViewController.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-11-02.
//  Copyright © 2015 LYM. All rights reserved.
//
//  The "Application Help" screen. One of two help screens.
//  Linked from the HelpEntranceViewController view controller.
//
//  HelpViewController is a controller with one main function: To display a collection view with images that show the functionality of some screens that seem ambiguous.
//  To do this, the application help images are put into an array, which will be used to declare the cells in the collection view

import UIKit

class HelpViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
//  Just like the MainViewController, the HelpViewController is given the properties of UICollectionViewDataSource and UICollectionViewDelegate, so that the collection view object can be modified by the data from this code
//  The functions of UIScrollViewDelegate are not implemented in this class, and therefore UIScrollViewDelegate is not called
//  All of the scrolling and locking mechanisms for the collection view in HelpViewController is one of the system defaults that can be modified in the storyboard

//  viewDidLoad is activated when the view first loads
//  viewDidLoad is a system default
//  In this particular class, the viewDidLoad method has no use
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    //The UICollectionView that displays the help manuals
    @IBOutlet weak var helpCollectionView: UICollectionView!
    
    //The imageArray that holds all the application help images in an array
    let imageArray = [UIImage(named:"Help Screen User Input"), UIImage(named:"Help Screen Pause"), UIImage(named:"Help Screen Time Trial Mode")]
    
    //A function that returns number of sections that will be in the collection view to the collection view
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    //A function that returns the number of items that will be in each section of the collection view to the collection view
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    
    //A function that takes the information from above two classes, and loads the collection view items as ordered
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //This function declares a cell object with the properties of HelpCollectionViewCell class
    
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Help Cell", forIndexPath: indexPath) as! HelpCollectionViewCell
        
        //Since the class HelpCollectionView has property called image, it can be modified from the HelpViewController through the declared cell
        
        cell.helpImage?.image = imageArray[indexPath.item]
        
        //The delared cell is returned to the collection view to be displayed
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

}
