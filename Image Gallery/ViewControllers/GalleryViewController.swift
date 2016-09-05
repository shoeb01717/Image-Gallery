//
//  GalleryViewController.swift
//  Image Gallery
//
//  Created by Shoeb Amin on 8/29/16.
//  Copyright © 2016 Tigerspike. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet var galleryCollectionView: UICollectionView!
    private let reuseIdentifier = "PhotoCell"
    private let sectionInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
    
    let gradientLayer = CAGradientLayer()
    
    var photoArray = [Photo]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        gradientLayer.frame = self.view.bounds
        
        let color1 = UIColor.yellowColor().colorWithAlphaComponent(0.2).CGColor as CGColorRef
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.1).CGColor as CGColorRef
        let color3 = UIColor.clearColor().CGColor as CGColorRef
        let color4 = UIColor(white: 0.0, alpha: 0.7).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2, color3, color4]
        
        gradientLayer.locations = [0.0, 0.25, 0.75, 1.0]
        
        self.view.layer.addSublayer(gradientLayer)
        
        let layout = self.galleryCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        WebServiceHandler.sharedInstance.fetchGalleryDataFromFlickr { (photos) in
            self.photoArray = photos
            self.galleryCollectionView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCollectionViewCell
        cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
        let photo = self.photoArray[indexPath.row]
        if let author = photo.author {
            cell.authorLabel.text = author
        }
        if let title = photo.title {
            cell.titleLabel.text = title
        }
        cell.photoImageView.imageFromUrl(photo.media) { (isSuccess) in
            
        }
        var width:Float?
        if let widthValue:Float = Float(photo.imageWidth) {
            width = widthValue
        } else {
            width = 100.0
        }
        var height:Float?
        if let heightValue:Float = Float(photo.imageHeight) {
            height = heightValue
        } else {
            height = 100.0
        }
        
        if width > 100 {
            height = (height!/width!) * 100.0
            width = 100
        }
        cell.photoWidth.constant = CGFloat(width!)
        cell.photoHeight.constant = CGFloat(height!)
        
        cell.layer.cornerRadius = 10.0
        cell.layer.borderColor = UIColor.grayColor().CGColor
        cell.layer.borderWidth = 2.0
        cell.clipsToBounds = true
        
        return cell
    }

}

extension GalleryViewController: UICollectionViewDelegate {

}

extension GalleryViewController : UICollectionViewDelegateFlowLayout {

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 20
    }

    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}