//
//  LoadingVC.swift
//  Genesis
//
//  Created by Fareed's Personal Account on 2018-04-18.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController {
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
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
