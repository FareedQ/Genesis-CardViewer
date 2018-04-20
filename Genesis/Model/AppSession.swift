//
//  appSession.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2017-12-29.
//  Copyright © 2017 Treefrog Inc. All rights reserved.
//

import WebKit
import CoreData

class AppSession {
    static let shared = AppSession()
    
    var cards:[NSManagedObject] = []
    var webView: WKWebView!
}
