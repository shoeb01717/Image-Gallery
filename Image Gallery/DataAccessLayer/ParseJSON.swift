//
//  ParseJSON.swift
//  Image Gallery
//
//  Created by Shoeb Amin on 8/31/16.
//  Copyright © 2016 Tigerspike. All rights reserved.
//

import UIKit

typealias commonType = [String: AnyObject]

class ParseJSON: NSObject {
    

    func parseFlickrPublicJSONFeed( data: NSData) -> [Photo] {
        var photos = [Photo]()
        var json = commonType()
        var jsonString = NSString(data: data, encoding: NSUTF8StringEncoding)
        jsonString = jsonString?.stringByReplacingOccurrencesOfString("\\'", withString: "'")
    
        do{
            json = try NSJSONSerialization.JSONObjectWithData(jsonString!.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.AllowFragments) as! commonType
            print(json)
        } catch {
            print(error)
        }
        

        guard let items = json["items"]
            else {return photos}
        for item in items as! NSMutableArray {
            
            let photo:Photo = Photo(photoDictionary: item as! NSDictionary)
            photos.append(photo)
        }
        
        
        return photos
    }
}
