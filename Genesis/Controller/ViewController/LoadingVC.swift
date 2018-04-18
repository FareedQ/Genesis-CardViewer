//
//  LoadingVC.swift
//  Genesis
//
//  Created by Fareed's Personal Account on 2018-04-18.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController {
    
    override func viewDidLoad() {
        APILayer.shared.loadAllCards {
            self.performSegue(withIdentifier: "loaded", sender: self)
        }
    }
    
}
