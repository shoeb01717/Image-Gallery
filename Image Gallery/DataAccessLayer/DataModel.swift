//
//  DataModel.swift
//  Image Gallery
//
//  Created by Shoeb Amin on 8/31/16.
//  Copyright © 2016 Tigerspike. All rights reserved.
//

import Foundation
import UIKit

struct Photo {
    
     var title : String!
     var link : String!
     var media : String!
     var date_taken : NSDate!
     var description : String!
     var published : NSDate!
     var author : String!
     var author_id : String!
     var tags : [String]!
     var imageWidth:Int!
     var imageHeight:Int!
    
    
    
    
    init(photoDictionary: NSDictionary)  {
        if let title = photoDictionary["title"] {
            self.title = title as! String
        }
        if let author = photoDictionary["author"] {
            self.author = author as! String
            self.author = self.author.stringByReplacingOccurrencesOfString("nobody@flickr.com ", withString: "")
            self.author = self.author.stringByReplacingOccurrencesOfString("(", withString: "")
            self.author = self.author.stringByReplacingOccurrencesOfString(")", withString: "")
            
        }
        
        if let author_id = photoDictionary["author_id"] {
            self.author_id = author_id as! String
        }
        
        if let description = photoDictionary["description"] {
            self.description = description as! String
            if let width:String =  Utils.findValueFromHtmlString(self.description, substring: "width", startIndexAdvance: 2, endIndexAdvance: 5){
                self.imageWidth = Int(width)
            }
            if let height:String = Utils.findValueFromHtmlString(self.description, substring: "height", startIndexAdvance: 2, endIndexAdvance: 5) {
                self.imageHeight = Int(height)
            }
        }
        
        if let link = photoDictionary["link"] {
            self.link = link as! String
        }
        
        if let tags:String = photoDictionary["tags"] as? String {
            self.tags = tags.componentsSeparatedByString(" ")
        }
        if let media:[String: String] = photoDictionary["media"] as? [String: String]{
            if let m = media["m"] as String!{
                self.media = m
            }
        }
    }
}