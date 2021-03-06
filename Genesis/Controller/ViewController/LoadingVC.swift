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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        do {
            //Load the cards from CoreData
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Card")
            let cards = try managedContext.fetch(fetchRequest) as! [Card]
            
            
            if !cards.isEmpty {
                //Delayed load to show off the splash screen
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.segueAfterLoad()
                }
            } else {
                //Load cards from web service
                APILayer.shared.loadAllCards(
                    update: { status in
                        dispatchMain {
                            self.lblStatus.text = "Loading card \(status)"
                        }
                }, success: {
                    self.segueAfterLoad()
                })
                
                
                //Begin Loading
                activityIndicator.isHidden = false
                lblStatus.text = "Downloading data from webservice"
            }
            
            
        } catch let error as NSError {
            alertSystemError {
                self.segueAfterLoad()
            }
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDefaults.standard.hasSeenDisclaimer() {
            alertDisclaimer(action: {})
        }
    }
    
    
    private func segueAfterLoad(){
        dispatchMain {
            self.performSegue(withIdentifier: "loaded", sender: self)
        }
    }
}
