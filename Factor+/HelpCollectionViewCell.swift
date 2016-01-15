//
//  HelpCollectionViewCell.swift
//  Factor+
//
//  Created by Leo Yoon on 2015-12-07.
//  Copyright © 2015 LYM. All rights reserved.
//
//  A class for cells. It's a class that has the functionality of the
//  UICollectionViewCell. This class is UICollectionViewCell with an image.
//
//  It's like adding an extra feature on top of the existing View Controller.
//  (Inheritance?)
//

import UIKit

class HelpCollectionViewCell: UICollectionViewCell {
    
    //used in the HelpViewController and HelpTwoViewController
    //the Help images
    @IBOutlet weak var helpImage : UIImageView!
}
