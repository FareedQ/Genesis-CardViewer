//
//  urlImageObject.swift
//  Genesis
//
//  Created by Fareed's Personal Account on 2018-04-18.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import Foundation
import UIKit

class urlImageObject {
    var image = UIImage()
    
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage, success: @escaping ()->()) {
        
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                        return
                    }
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            dispatchMain {
                                self.image = downloadedImage
                                success()
                            }
                        } else {
                            self.image = placeHolder
                            success()
                        }
                    }
                }
            }).resume()
        }
    }
    
}
