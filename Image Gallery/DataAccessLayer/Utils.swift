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
