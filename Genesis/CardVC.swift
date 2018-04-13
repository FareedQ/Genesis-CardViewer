//
//  CardVC.swift
//  Genesis
//
//  Created by Fareed Quraishi on 2018-01-25.
//  Copyright © 2018 Treefrog Inc. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func btnClosedClicked(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    func fadeIn() {
        UIView.animate(withDuration: 0.1, animations: {
            self.btnClose.alpha = 1
        })
    }
    
}
