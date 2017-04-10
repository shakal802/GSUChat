//
//  Extensions.swift
//  GSUChat
//
//  Created by Shakal Uddin on 2/12/17.
//  Copyright © 2017 Shakal Uddin. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
        
     
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage as! UIImage
            return
        }
        
   
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url as! URL, completionHandler: { (data, response, error) in
            
     
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                    self.image = downloadedImage
                }
            })
        }).resume()
    }
    
}
