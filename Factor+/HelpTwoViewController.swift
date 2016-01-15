//
//  HelpTwoViewController.swift
//  Factor+
//
//  Created by Leo Yoon on 2016-01-05.
//  Copyright © 2016 LYM. All rights reserved.
//
//  The "Math Help" screen. One of two help screens.
//  Linked from the HelpEntranceViewController view controller.
//
//  The HelpTwoViewController has the same functionalities and code as HelpViewController
//  The difference is in the imageArray, since the help images aid students in solving math problems instead of navigation of the app
//  This class may be merged with HelpViewController, so that there would be one class but two imageArrays that will activate depending on which help menu was clicked

import UIKit

class HelpTwoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBOutlet weak var helpCollectionView: UICollectionView!
    
    let imageArray = [UIImage(named:"Help Screen Basic Factoring"),UIImage(named:"Help Screen Graph to Equation"),UIImage(named:"Help Screen Advanced Factoring 1"),UIImage(named:"Help Screen Advanced Factoring 2")]
    
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
