//
//  OptionsCollectionViewCell.swift
//  Factor+
//
//  Created by Taehyun Lee on 2015-10-26.
//  Copyright © 2015 LYM. All rights reserved.
//
//  A class for cells. It's a class that has the functionality of the
//  UICollectionViewCell. This class is UICollectionViewCell with an image.
//
//  It's like adding an extra feature on top of the existing View Controller.
//  (Inheritance?)
//

import UIKit

class OptionsCollectionViewCell: UICollectionViewCell {
    
    //used in MainViewController
    //it's the three banners for each option (Help, Start, Credit)
    @IBOutlet weak var featuredImage : UIImageView!
}
