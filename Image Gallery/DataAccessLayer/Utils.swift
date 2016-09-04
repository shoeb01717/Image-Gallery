//
//  Utils.swift
//  Image Gallery
//
//  Created by Shoeb Amin on 9/4/16.
//  Copyright © 2016 Tigerspike. All rights reserved.
//

import UIKit

class Utils: NSObject {

    static func DateFromString(string :String, format: String) -> NSDate {
    
        let dateString = string.stringByReplacingOccurrencesOfString("T", withString: " ") // change to your date format
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.dateFromString(dateString)
        return date!
    }
}


extension UIImageView {
    public func imageFromUrl(urlString: String, completionHandler: (isSuccess: Bool , error:NSError) -> Void) {

        let nsURL = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL!) {
            (data, response, error) in
            
            if (error == nil) {
                NSLog("No Error!")
                let image:UIImage = UIImage(data: data!)!
                self.image = image
                completionHandler(isSuccess: true, error: error!)
            }
            else {
                NSLog("Error!")
                completionHandler(isSuccess: false, error: error!)
            }
        }
        
        task.resume()
    }
    
    
}