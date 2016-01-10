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

import UIKit

class HelpTwoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        // Dispose of any resources that can be recreated.
    }

}
