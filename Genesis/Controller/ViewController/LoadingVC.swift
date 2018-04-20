//
//  LoadingVC.swift
//  Genesis
//
//  Created by Fareed's Personal Account on 2018-04-18.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import UIKit
import WebKit
import CoreData

class LoadingVC: UIViewController {
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        
        //Loads the Webview to prevent later loading
        let webConfiguration = WKWebViewConfiguration()
        AppSession.shared.webView = WKWebView(frame: view.frame, configuration: webConfiguration)
        let myURL = URL(string: "http://www.genesisbattleofchampions.com")
        let myRequest = URLRequest(url: myURL!)
        AppSession.shared.webView.load(myRequest)
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Card")
        
        do {
            AppSession.shared.cards = try managedContext.fetch(fetchRequest)
            if AppSession.shared.cards.isEmpty {
                APILayer.shared.loadAllCards(
                    update: { status in
                        dispatchMain {
                            self.lblStatus.text = "Loading card \(status)"
                        }
                }, success: {
                    self.segueAfterLoad()
                })
            } else {
                self.segueAfterLoad()
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            //Loads the cards
        }
    }
    
    
    func segueAfterLoad(){
        dispatchMain {
            self.performSegue(withIdentifier: "loaded", sender: self)
        }
    }
}
