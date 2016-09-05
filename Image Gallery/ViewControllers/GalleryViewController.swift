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
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var photoArray = [Photo]()
    override func viewDidLoad() {
        super.viewDidLoad()

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
        cell.backgroundColor = UIColor.blackColor()
        let photo = self.photoArray[indexPath.row]
        cell.photoImageView.imageFromUrl(photo.media) { (isSuccess) in
            
        }
        return cell
    }

}

extension GalleryViewController: UICollectionViewDelegate {

}

extension GalleryViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let photo = self.photoArray[indexPath.row]

        return CGSize(width: photo.imageWidth, height: photo.imageHeight)
    }
    

    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}