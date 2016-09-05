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
    
    static func findValueFromHtmlString(givenString:String, substring:String, startIndexAdvance:Int, endIndexAdvance:Int) -> String {
        var rangeofSubsString = givenString.rangeOfString(substring)
        rangeofSubsString?.startIndex = (rangeofSubsString?.endIndex)!.advancedBy(startIndexAdvance)
        rangeofSubsString?.endIndex = (rangeofSubsString?.endIndex)!.advancedBy(endIndexAdvance)
        let value = givenString.substringWithRange(rangeofSubsString!)
        return value
    }
}



extension UIImageView {
    public func imageFromUrl(urlString: String, completionHandler: (isSuccess: Bool) -> Void) {

        let nsURL = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL!) {
            (data, response, error) in
            
            if (error == nil) {
                NSLog("No Error!")
                let image:UIImage = UIImage(data: data!)!
                dispatch_async(dispatch_get_main_queue(),{
                    self.image = image
                    completionHandler(isSuccess: true)
                })
                
            }
            else {
                NSLog("Error!")
                dispatch_async(dispatch_get_main_queue(),{
                    completionHandler(isSuccess: false)
                })
            }
        }
        
        task.resume()
    }
    
    
}