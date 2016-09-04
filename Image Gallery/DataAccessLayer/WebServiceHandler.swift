//
//  WebServiceHandler.swift
//  Image Gallery
//
//  Created by Shoeb Amin on 8/29/16.
//  Copyright © 2016 Tigerspike. All rights reserved.
//

import UIKit

class WebServiceHandler: NSObject {

    static let sharedInstance = WebServiceHandler()
    let webServiceAddress = Constants.WebService.WebServiceBaseAddress
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?

    func fetchGalleryDataFromFlickr(onSuccess completionHandler:((photos:[Photo]) -> Void))  {
        if dataTask != nil {
            dataTask?.cancel()
        }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let url = NSURL(string: webServiceAddress)
        
        dataTask = defaultSession.dataTaskWithURL(url!) {
            data, response, error in
            
            dispatch_async(dispatch_get_main_queue()) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? NSHTTPURLResponse {
            
                if httpResponse.statusCode == 200 {
                    let parseJSON = ParseJSON()
                    let photosArray = parseJSON.parseFlickrPublicJSONFeed(data!)
                    if photosArray.count > 0 {
                        completionHandler(photos: photosArray)
                    }
                }
            }
        }
        
        dataTask?.resume()
        
    }

}
