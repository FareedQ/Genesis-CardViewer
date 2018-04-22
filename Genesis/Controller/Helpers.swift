//
//  Helpers.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import Foundation

// Just a coding style a mentor of mine used and I've always liked.
func dispatchMain(closure: @escaping ()->()) {
    DispatchQueue.main.async {
        closure()
    }
}
