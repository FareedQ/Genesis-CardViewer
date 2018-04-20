//
//  extensions.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
let defaultCardImage = UIImage(named: "default_card")!

func dispatchMain(closure: @escaping ()->()) {
    DispatchQueue.main.async {
        closure()
    }
}

protocol ListViewDelegate: class {
    func refreshList()
}



extension UIImageView {
    
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
                    dispatchMain {
                        self.image = placeHolder
                    }
                    complete()
                    return
                }
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                        dispatchMain {
                            self.image = downloadedImage
                        }
                        complete()
                    } else {
                        dispatchMain {
                            self.image = placeHolder
                        }
                        complete()
                    }
                }
            }).resume()
        }
    }
}
