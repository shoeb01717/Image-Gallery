//
//  PhotoCollectionViewCell.swift
//  Image Gallery
//
//  Created by Shoeb Amin on 9/5/16.
//  Copyright © 2016 Tigerspike. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var photoHeight: NSLayoutConstraint!
    
    @IBOutlet var photoWidth: NSLayoutConstraint!
    
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
}
