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
    
    
    init(photoDictionary: NSDictionary)  {
        
        if let author = photoDictionary["author"] {
            self.author = author as! String
        }
        
        if let author_id = photoDictionary["author_id"] {
            self.author_id = author_id as! String
        }
        
        if let description = photoDictionary["description"] {
            self.description = description as! String
        }
        
        if let link = photoDictionary["link"] {
            self.link = link as! String
        }
        
        if let tags:String = photoDictionary["tags"] as? String {
            self.tags = tags.componentsSeparatedByString(" ")
        }
    }
}