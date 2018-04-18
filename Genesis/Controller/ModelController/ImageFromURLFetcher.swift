//
//  urlImageObject.swift
//  Genesis
//
//  Created by Fareed's Personal Account on 2018-04-18.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import Foundation
import UIKit

class ImageFromURLFetcher {
    var image = UIImage()
    
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage, complete: @escaping ()->()) {
        
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            complete()
            return
        }
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    self.image = placeHolder
                    complete()
                    return
                }
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                            complete()
                    } else {
                        self.image = placeHolder
                        complete()
                    }
                }
            }).resume()
        }
    }
    
}
