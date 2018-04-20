//
//  AboutVC.swift
//  Genesis
//
//  Created by Fareed's Personal Account on 2018-04-20.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import UIKit
import WebKit

class AboutVC : UIViewController, WKUIDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppSession.shared.webView.uiDelegate = self
        view = AppSession.shared.webView
    }
    
}
