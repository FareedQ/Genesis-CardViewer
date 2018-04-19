//
//  extensions.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

func dispatchMain(closure: @escaping ()->()) {
    DispatchQueue.main.async {
        closure()
    }
}
