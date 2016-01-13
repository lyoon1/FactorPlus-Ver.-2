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
//  

import UIKit

class HelpViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    //the UICollectionView that displays the help manuals
    @IBOutlet weak var helpCollectionView: UICollectionView!
    
    let imageArray = [UIImage(named:"Help Screen User Input"), UIImage(named:"Help Screen Pause"), UIImage(named:"Help Screen Time Trial Mode")]
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Help Cell", forIndexPath: indexPath) as! HelpCollectionViewCell
        
        cell.helpImage?.image = imageArray[indexPath.item]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

}
