//
//  Helpers.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import Foundation
import UIKit

// Just a coding style a mentor of mine used and I've always liked.
func dispatchMain(closure: @escaping ()->()) {
    DispatchQueue.main.async {
        closure()
    }
}


extension UIImageView {
    func resizeImage(newWidth: CGFloat) {
        
        if let height = self.image?.size.height,
            let width = self.image?.size.width {
            let scale = newWidth / width
            let newHeight = height * scale
            UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
            self.image?.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            self.image = newImage
        }
    }
}
