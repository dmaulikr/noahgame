//
//  Extensions.swift
//  NoahGame
//
//  Created by Technorides on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, UIImage>()

extension UIImageView {

    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        if let url = URL(string: urlString) {
        
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                        
                        self.image = downloadedImage
                    }
                    
                }
                
            }).resume()
            
        }
    }
    
}
