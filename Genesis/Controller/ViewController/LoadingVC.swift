//
//  LoadingVC.swift
//  Genesis
//
//  Created by Fareed's Personal Account on 2018-04-18.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import UIKit
import WebKit

class LoadingVC: UIViewController {
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        
        //Loads the Webview to prevent later loading
        let webConfiguration = WKWebViewConfiguration()
        AppSession.shared.webView = WKWebView(frame: view.frame, configuration: webConfiguration)
        let myURL = URL(string: "http://www.genesisbattleofchampions.com")
        let myRequest = URLRequest(url: myURL!)
        AppSession.shared.webView.load(myRequest)
        
        
        
        //Loads the cards
        APILayer.shared.loadAllCards(
            update: { status in
                dispatchMain {
                    self.lblStatus.text = "Loading card \(status)"
                }
        }, success: {
            dispatchMain {
                self.performSegue(withIdentifier: "loaded", sender: self)
            }
        })
    }
    
}
