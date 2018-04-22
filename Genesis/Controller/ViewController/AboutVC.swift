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
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //App loading screen has a slow load. Need to figure that out or take out this web view content.
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: view.frame, configuration: webConfiguration)
        let myURL = URL(string: "http://www.genesisbattleofchampions.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        webView.uiDelegate = self
        view = webView
    }
    
}
