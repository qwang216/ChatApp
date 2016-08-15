//
//  Extensions.swift
//  ChatApp
//
//  Created by Jason Wang on 8/15/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

let imageCache = NSCache()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: String) {
        self.image = nil
        // check image in cache
        if let cachedImage = imageCache.objectForKey(urlString) as? UIImage {
            self.image = cachedImage
            return
        }

        // if no cache image found then download image
        let url = NSURL(string: urlString)
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                // cache image
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString)
                    self.image = UIImage(data: data!)
                }
            })
        }).resume()
    }
}
